import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/psytest/model/test_model.dart';
import 'package:wg_app/app/screens/psytest/network/test_network.dart';

part 'test_bloc_event.dart';
part 'test_bloc_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  List<String> _answers = [];

  TestBloc() : super(TestBlocInitial()) {
    on<LoadTestEvent>(_onLoadQuestions);
    on<AnswersQuestions>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    // on<CheckTestCompletion>(_onCheckTestCompletion);
  }

  // Future<void> _onCheckTestCompletion(CheckTestCompletion event, Emitter<TestState> emit) async {
  //   try {

  //   }
  // }

  Future<void> _onLoadQuestions(
      LoadTestEvent event, Emitter<TestState> emit) async {
    emit(TestLoadingState());
    try {
      final TestModel? quizData = await TestNetwork().loadTests();

      if (quizData != null) {
        _answers =
            List.filled(quizData.testingMaterial?.problems?.length ?? 0, '');

        emit(TestSuccessState(
          questions: quizData.testingMaterial?.problems ?? [],
          currentIndex: 0,
          testType: quizData.testingMaterial?.testType?.toUpperCase() ?? '',
          timeLimit: quizData.testingMaterial?.timeLimit,
          description: quizData.testingMaterial?.description,
          thumbnail: quizData.testingMaterial?.thumbnail,
          sId: event.sId,
        ));
      } else {
        emit(TestErrorState("Failed to load quiz data"));
      }
    } catch (e) {
      emit(TestErrorState("An error occurred: ${e.toString()}"));
    }
  }

  void _onAnswerQuestion(AnswersQuestions event, Emitter<TestState> emit) {
    if (state is TestSuccessState) {
      final currentState = state as TestSuccessState;
      final currentAnswers = currentState.selectedAnswer?.split(',') ?? [];

      if (event.isMultipleChoice) {
        if (currentAnswers.contains(event.answer)) {
          currentAnswers.remove(event.answer);
        } else {
          currentAnswers.add(event.answer);
        }
      } else {
        currentAnswers.clear();
        currentAnswers.add(event.answer);
      }

      emit(currentState.copyWith(
        selectedAnswer: currentAnswers.join(','),
      ));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<TestState> emit) {
    final state = this.state as TestSuccessState;
    final currentIndex = state.currentIndex;
    _answers[currentIndex] = event.selectedAnswer;
    if (currentIndex < state.questions.length - 1) {
      emit(state.copyWith(
        currentIndex: currentIndex + 1,
        selectedAnswer: _answers[currentIndex + 1],
      ));
    } else {
      _answers[currentIndex] = event.selectedAnswer;
      _submitAnswers();
      emit(TestCompletedState());
    }
  }

  void _onPreviousQuestion(PreviousQuestion event, Emitter<TestState> emit) {
    final state = this.state as TestSuccessState;
    final currentIndex = state.currentIndex;
    if (currentIndex > 0) {
      emit(state.copyWith(
        currentIndex: currentIndex - 1,
        selectedAnswer: _answers[currentIndex - 1],
      ));
    }
  }

  void _submitAnswers() async {
    final answersMap = {
      'answers': _answers,
    };

    try {
      await TestNetwork().submitTestAnswers(answersMap);
      print("Answers submitted: $_answers");
    } catch (e) {
      print("Failed to submit answers: ${e.toString()}");
      emit(TestErrorState("Failed to submit answers"));
    }
  }

  @override
  Future<void> close() {
    _answers.clear();
    return super.close();
  }
}

class ProgressBloc extends Cubit<double> {
  ProgressBloc() : super(0.2);

  void updateProgress(double progress) {
    emit(progress);
  }
}
