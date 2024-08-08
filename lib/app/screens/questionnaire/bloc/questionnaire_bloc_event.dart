part of 'questionnaire_bloc.dart';

@immutable
sealed class QuestionnaireEvent {}

class LoadQuestions extends QuestionnaireEvent {}

class AnswersQuestions extends QuestionnaireEvent {
  final String answer;
  final bool isMultipleChoice;
  AnswersQuestions(this.answer, this.isMultipleChoice);
}

class NextQuestion extends QuestionnaireEvent {
  final String selectedAnswer;

  NextQuestion(this.selectedAnswer);
}

class PreviousQuestion extends QuestionnaireEvent {}
