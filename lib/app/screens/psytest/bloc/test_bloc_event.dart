part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class LoadQuestions extends TestEvent {}

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
