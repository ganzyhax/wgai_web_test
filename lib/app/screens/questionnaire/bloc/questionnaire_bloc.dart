import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart'; // Import Hive
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/questionnaire/model/testing_model.dart';
import 'package:wg_app/app/screens/questionnaire/network/questionnaire_network.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/utils/quizbox_data.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  List<List<int>> _answers = [];
  late String _testingCode; // Store the current testingCode
  List<Map<String, dynamic>> chatMessage = [];
  final QuizBoxData quizBoxData = QuizBoxData();

  QuestionnaireBloc() : super(QuestionnaireInitial()) {
    on<LoadQuestionnaire>(_onLoadQuestionnaire);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CompleteQuestionnaire>(_onCompleteQuestionnaire);
  }

  Future<void> _onLoadQuestionnaire(
      LoadQuestionnaire event, Emitter<QuestionnaireState> emit) async {
    emit(QuestionnaireLoadingState());
    _testingCode = event.testingCode; // Store the current testing code
    chatMessage.clear();
    try {
      final TestingModel? data =
          await QuestionnaireNetwork().getQuestionnaire(event.testingCode);

      if (data != null) {
        final localLang = await LocalUtils.getLanguage();
        var testingTitle = data.testingMaterial?.title?.ru ?? '';
        if (localLang == 'kk') {
          testingTitle = data.testingMaterial?.title?.kk ?? '';
        }

        if (data.testingMaterial?.problems?.isNotEmpty ?? false) {
          _answers = List.generate(
              data.testingMaterial?.problems?.length ?? 0, (_) => []);
        }

        if (quizBoxData.hasQuizProgress(event.testingCode)) {
          final savedData = quizBoxData.getQuizProgress(event.testingCode);

          for (var i = 0; i <= savedData!['currentIndex']; i++) {
            var quest = data.testingMaterial!.problems![i];
            log(savedData['answers'].toString());
            log(savedData['currentIndex'].toString());

            if (savedData['answers'][i].isNotEmpty) {
              if (quest.problemType == 'poster') {
                chatMessage.add({
                  'isQuestion': true,
                  'image': quest.image!.kk
                      .toString(), // Assuming this gets the image path or URL
                });
              } else {
                chatMessage.add({
                  'isQuestion': true,
                  'text': quest.question!.kk
                      .toString(), // Add the question text in Kazakh
                });
              }
              int answerIndex = savedData['answers'][i][
                  0]; // Assuming the first element of the array holds the selected answer index

              chatMessage.add({
                'isQuestion': false,
                'text': quest.options![answerIndex].answer!.kk
                    .toString(), // Get the answer text based on the index
              });
            } else {}
          }
          emit(QuestionnaireSetLocalData(data: chatMessage));

          if (savedData != null) {
            _answers = List<List<int>>.from(
              (savedData['answers'] as List).map(
                (e) => List<int>.from(
                    e as List<dynamic>), // Casting each inner list
              ),
            );
            final currentIndex = savedData['currentIndex'] + 1;
            // log(_answers[currentIndex].toString());
            emit(QuestionnaireSuccessState(
              questions: data.testingMaterial?.problems ?? [],
              currentIndex: currentIndex,
              selectedAnswerIndices: (_answers.length == 0)
                  ? []
                  : _answers[currentIndex] as List<int>,
              questionnaireTitle: testingTitle,
              portraitImage: data.testingMaterial?.problems ?? [],
              isMultipleChoice: data.testingMaterial?.problems ?? [],
            ));
          }
        } else {
          emit(QuestionnaireSuccessState(
            questions: data.testingMaterial?.problems ?? [],
            currentIndex: 0,
            selectedAnswerIndices: [],
            questionnaireTitle: testingTitle,
            portraitImage: data.testingMaterial?.problems ?? [],
            isMultipleChoice: data.testingMaterial?.problems ?? [],
          ));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(QuestionnaireErrorState("Failed to load questionnaire"));
    }
  }

  void _onAnswerQuestion(
      AnswerQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      final selectedIndices =
          List<int>.from(currentState.selectedAnswerIndices);

      if (event.isMultipleChoice) {
        if (selectedIndices.contains(event.answerIndex)) {
          selectedIndices.remove(event.answerIndex);
        } else {
          selectedIndices.add(event.answerIndex);
        }
      } else {
        selectedIndices.clear();
        selectedIndices.add(event.answerIndex);
      }

      // Ensure the index is valid

      if (currentState.currentIndex < _answers.length) {
        _answers[currentState.currentIndex] = selectedIndices;
        quizBoxData.saveQuizProgress(
          _testingCode,
          _answers,
          currentState.currentIndex,
        );
        emit(currentState.copyWith(selectedAnswerIndices: selectedIndices));
      } else {
        log('Invalid currentIndex: ${currentState.currentIndex}');
      }
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      if (currentState.currentIndex < currentState.questions.length) {
        final currentAnswers =
            List<int>.from(currentState.selectedAnswerIndices);

        // Ensure index is valid
        if (currentState.currentIndex < _answers.length) {
          _answers[currentState.currentIndex] = currentAnswers;
        } else {
          log('Invalid currentIndex: ${currentState.currentIndex}');
          return;
        }

        if (currentState.currentIndex == currentState.questions.length - 1) {
          // Handle the last question
          if (currentState.selectedAnswerIndices.isNotEmpty ||
              currentState.questions[currentState.currentIndex].problemType ==
                  'poster') {
            emit(QuestionnaireCompletedState(_answers));
          }
        } else {
          final nextIndex = currentState.selectedAnswerIndices.isNotEmpty
              ? currentState
                  .questions[currentState.currentIndex]
                  .options![currentState.selectedAnswerIndices[0]]
                  .nextQuestionIndex
              : currentState.currentIndex + 1;
          emit(currentState.copyWith(
            currentIndex: nextIndex,
            selectedAnswerIndices:
                _answers[nextIndex!], // Ensure next index is valid
          ));
        }
      }
    }
  }

  void _onPreviousQuestion(
      PreviousQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState &&
        currentState.currentIndex > 0) {
      final previousIndex = currentState.currentIndex - 1;
      emit(currentState.copyWith(
        currentIndex: previousIndex,
        selectedAnswerIndices: _answers[previousIndex],
      ));
    }
  }

  void _onCompleteQuestionnaire(
      CompleteQuestionnaire event, Emitter<QuestionnaireState> emit) async {
    try {
      await QuestionnaireNetwork()
          .submitAnswers(event.answers, event.taskId, event.isGuidanceTask);
      quizBoxData.clearQuizProgress(_testingCode);
      emit(QuestionnaireSubmittedState());
    } catch (e) {
      emit(QuestionnaireErrorState("Failed to submit questionnaire"));
    }
  }
}
