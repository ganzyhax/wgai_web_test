part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class CheckTestCompletion extends TestEvent {}

class LoadQuestions extends TestEvent {
  LoadQuestions();
}

class LoadTestEvent extends TestEvent {
  final String sId;
  LoadTestEvent(this.sId);
}

class AnswersQuestions extends TestEvent {
  final String answer;
  final bool isMultipleChoice;
  AnswersQuestions(this.answer, this.isMultipleChoice);
}

class NextQuestion extends TestEvent {
  final String selectedAnswer;

  NextQuestion(this.selectedAnswer);
}

class PreviousQuestion extends TestEvent {}
