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

    if (quizBoxData.hasQuizProgress(event.testingCode)) {
      // Retrieve saved data
      final savedData = quizBoxData.getQuizProgress(event.testingCode);
      _answers = List<List<int>>.from(savedData!['answers']);
      final currentIndex = savedData!['currentIndex'];
      emit(QuestionnaireSuccessState(
        questions: savedData!['questions'],
        currentIndex: currentIndex,
        selectedAnswerIndices: _answers[currentIndex],
        questionnaireTitle: savedData['title'],
        portraitImage: savedData['portraitImage'],
        isMultipleChoice: savedData['isMultipleChoice'],
      ));
      return;
    }

    try {
      // Fetch new questionnaire data from the network
      final TestingModel? data =
          await QuestionnaireNetwork().getQuestionnaire(event.testingCode);

      if (data != null) {
        final localLang = await LocalUtils.getLanguage();
        var testingTitle = data.testingMaterial?.title?.ru ?? '';
        if (localLang == 'kk') {
          testingTitle = data.testingMaterial?.title?.kk ?? '';
        }

        _answers = List.generate(
            data.testingMaterial?.problems?.length ?? 0, (_) => []);

        final questions = data.testingMaterial?.problems ?? [];

        // Save initial data in Hive
        q.put(_testingCode, {
          'answers': _answers,
          'currentIndex': 0,
          'questions': questions,
          'title': testingTitle,
          'portraitImage': questions,
          'isMultipleChoice': questions,
        });

        emit(QuestionnaireSuccessState(
          questions: questions,
          currentIndex: 0,
          selectedAnswerIndices: [],
          questionnaireTitle: testingTitle,
          portraitImage: questions,
          isMultipleChoice: questions,
        ));
      }
    } catch (e) {
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

      // Update answers and save to Hive
      _answers[currentState.currentIndex] = selectedIndices;
      quizBox.put(_testingCode, {
        'answers': _answers,
        'currentIndex': currentState.currentIndex,
        'questions': currentState.questions,
        'title': currentState.questionnaireTitle,
        'portraitImage': currentState.portraitImage,
        'isMultipleChoice': currentState.isMultipleChoice,
      });

      emit(currentState.copyWith(selectedAnswerIndices: selectedIndices));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState &&
        currentState.currentIndex < currentState.questions.length - 1) {
      final nextIndex = currentState.currentIndex + 1;
      emit(currentState.copyWith(
        currentIndex: nextIndex,
        selectedAnswerIndices: _answers[nextIndex],
      ));
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
      quizBox.delete(_testingCode); // Clear saved data upon submission
      emit(QuestionnaireSubmittedState());
    } catch (e) {
      emit(QuestionnaireErrorState("Failed to submit questionnaire"));
    }
  }
}
