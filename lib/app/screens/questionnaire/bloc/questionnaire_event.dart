part of 'questionnaire_bloc.dart';

@immutable
sealed class QuestionnaireEvent {}

class LoadQuestionnaire extends QuestionnaireEvent {}

class AnswerQuestion extends QuestionnaireEvent {
  final String answer;
  final bool isMultipleChoice;
  final bool isPoster;

  AnswerQuestion(this.answer, this.isMultipleChoice, this.isPoster);
}

class NextQuestion extends QuestionnaireEvent {
  final List<String> selectedAnswer;

  NextQuestion(this.selectedAnswer);
}

class PreviousQuestion extends QuestionnaireEvent {}
