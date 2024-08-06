import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';
import 'package:wg_app/app/screens/questionnaire/model/task_model.dart';
import 'package:wg_app/app/screens/questionnaire/network/questionnaire_network.dart';

part 'questionnaire_bloc_event.dart';
part 'questionnaire_bloc_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  QuestionnaireBloc() : super(QuestionnaireBlocInitial()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<AnswersQuestions>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
  }

  Future<void> _onLoadQuestions(
      LoadQuestions event, Emitter<QuestionnaireState> emit) async {
    emit(QuestionnaireLoadingState());
    try {
      List<Task> questions = await QuestionnaireNetwork().loadTasks();
      emit(QuestionnaireSuccessState(
        questions: questions,
        currentIndex: 0,
      ));
    } catch (e) {
      emit(QuestionnaireErrorState("Failed to load quiz"));
    }
  }

  void _onAnswerQuestion(
      AnswersQuestions event, Emitter<QuestionnaireState> emit) {
    if (state is QuestionnaireSuccessState) {
      final currentState = state as QuestionnaireSuccessState;

      if (currentState.currentIndex < currentState.questions.length - 1) {
        emit(QuestionnaireSuccessState(
          questions: currentState.questions,
          currentIndex: currentState.currentIndex + 1,
        ));
      } else {
        emit(QuestionnaireCompletedState());
      }
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuestionnaireState> emit) {
    final state = this.state as QuestionnaireSuccessState;
    final currentIndex = state.currentIndex;
    if (currentIndex < state.questions.length - 1) {
      emit(state.copyWith(
        currentIndex: currentIndex + 1,
        selectedAnswer: null,
      ));
    } else {
      emit(QuestionnaireCompletedState());
    }
  }

  void _onPreviousQuestion(
      PreviousQuestion event, Emitter<QuestionnaireState> emit) {
    final state = this.state as QuestionnaireSuccessState;
    final currentIndex = state.currentIndex;
    if (currentIndex > 0) {
      emit(state.copyWith(
        currentIndex: currentIndex - 1,
        selectedAnswer: null,
      ));
    }
  }
}

class ProgressBloc extends Cubit<double> {
  ProgressBloc() : super(0.2);

  void updateProgress(double progress) {
    emit(progress);
  }
}
