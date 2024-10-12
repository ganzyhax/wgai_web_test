import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/questionnaire/model/testing_model.dart';
import 'package:wg_app/app/screens/questionnaire/network/questionnaire_network.dart';
import 'package:wg_app/app/utils/local_utils.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  // List<List<String>> _answers = [];
  List<List<int>> _answers = [];

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
    try {
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
        emit(QuestionnaireSuccessState(
          questions: data.testingMaterial?.problems ?? [],
          currentIndex: 0,
          selectedAnswerIndices: [],
          questionnaireTitle: testingTitle,
          portraitImage: data.testingMaterial?.problems ?? [],
          isMultipleChoice: data.testingMaterial?.problems ?? [],
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
      emit(currentState.copyWith(selectedAnswerIndices: selectedIndices));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      if (currentState.currentIndex <= currentState.questions.length - 1) {
        final currentAnswers =
            List<int>.from(currentState.selectedAnswerIndices);
        _answers[currentState.currentIndex] = currentAnswers;
        if (currentState.currentIndex == currentState.questions.length - 1) {
          if (currentState.questions[currentState.currentIndex].problemType ==
                  'poster' ||
              currentState.selectedAnswerIndices.length > 0) {
            emit(QuestionnaireCompletedState(_answers));
          }
        } else if (currentState.selectedAnswerIndices.length > 0 ||
            currentState.questions[currentState.currentIndex].problemType ==
                'poster') {
          // next index is provided in the document unless the question is a poster, in which case just go to the next index
          final nextIndex = currentState.selectedAnswerIndices.length > 0
              ? currentState
                  .questions[currentState.currentIndex]
                  .options![currentState.selectedAnswerIndices[0]]
                  .nextQuestionIndex
              : currentState.currentIndex + 1;
          emit(currentState.copyWith(
            currentIndex: nextIndex,
            selectedAnswerIndices: _answers[currentState.currentIndex + 1],
          ));
        }
      }
    }
  }

  // left it out for now, will implement later
  void _onPreviousQuestion(
      PreviousQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      if (currentState.currentIndex > 0) {
        final currentAnswers =
            List<int>.from(currentState.selectedAnswerIndices);
        _answers[currentState.currentIndex] = currentAnswers;
        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex - 1,
          selectedAnswerIndices: _answers[currentState.currentIndex - 1],
        ));
      }
    }
  }

  void _onCompleteQuestionnaire(
      CompleteQuestionnaire event, Emitter<QuestionnaireState> emit) async {
    try {
      // upon completing the questionnaire, the answers are sent to the backend for processing
      await QuestionnaireNetwork()
          .submitAnswers(event.answers, event.taskId, event.isGuidanceTask);
      emit(QuestionnaireSubmittedState());
    } catch (e) {
      emit(QuestionnaireErrorState("Failed to submit questionnaire"));
    }
  }
}
