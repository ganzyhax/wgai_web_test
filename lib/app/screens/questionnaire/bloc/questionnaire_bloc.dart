import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/psytest/model/test_model.dart';
import 'package:wg_app/app/screens/questionnaire/network/questionnaire_network.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  List<List<String>> _answers = [];

  QuestionnaireBloc() : super(QuestionnaireInitial()) {
    on<LoadQuestionnaire>(_onLoadQuestionnaire);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
  }

  Future<void> _onLoadQuestionnaire(
      LoadQuestionnaire event, Emitter<QuestionnaireState> emit) async {
    emit(QuestionnaireLoadingState());
    try {
      final TestModel? data = await QuestionnaireNetwork().getQuestionnaire();

      if (data != null) {
        _answers = List.generate(
            data.testingMaterial?.problems?.length ?? 0, (_) => []);

        emit(QuestionnaireSuccessState(
          questions: data.testingMaterial?.problems ?? [],
          currentIndex: 0,
          selectedAnswers: [],
          questionnaireType:
              data.testingMaterial?.testType?.toUpperCase() ?? '',
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
      final selectedAnswers = List<String>.from(currentState.selectedAnswers);
      if (event.isMultipleChoice) {
        if (selectedAnswers.contains(event.answer)) {
          selectedAnswers.remove(event.answer);
        } else {
          selectedAnswers.add(event.answer);
        }
      } else {
        selectedAnswers.clear();
        selectedAnswers.add(event.answer);
      }
      emit(currentState.copyWith(selectedAnswers: selectedAnswers));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      if (currentState.currentIndex < currentState.questions.length - 1) {
        final currentAnswers = List<String>.from(currentState.selectedAnswers);
        _answers[currentState.currentIndex] = currentAnswers;

        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          selectedAnswers: _answers[currentState.currentIndex + 1],
        ));
      } else {
        emit(QuestionnaireCompletedState());
      }
    }
  }

  void _onPreviousQuestion(
      PreviousQuestion event, Emitter<QuestionnaireState> emit) {
    final currentState = state;
    if (currentState is QuestionnaireSuccessState) {
      if (currentState.currentIndex > 0) {
        final currentAnswers = List<String>.from(currentState.selectedAnswers);
        _answers[currentState.currentIndex] = currentAnswers;

        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex - 1,
          selectedAnswers: _answers[currentState.currentIndex - 1],
        ));
      }
    }
  }
}
