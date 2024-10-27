part of 'questionnaire_bloc.dart';

@immutable
abstract class QuestionnaireEvent {}

class LoadQuestionnaire extends QuestionnaireEvent {
  final String testingCode;

  LoadQuestionnaire(this.testingCode);
}

class AnswerQuestion extends QuestionnaireEvent {
  final int answerIndex;  // Changed from String answer to int answerIndex
  final bool isMultipleChoice;
  final bool isPoster;

  AnswerQuestion(this.answerIndex, this.isMultipleChoice, this.isPoster);
}

class NextQuestion extends QuestionnaireEvent {}

class PreviousQuestion extends QuestionnaireEvent {}

class CompleteQuestionnaire extends QuestionnaireEvent {
  final List<List<int>> answers;
  final String taskId;
  final bool isGuidanceTask;

  CompleteQuestionnaire(this.answers, this.taskId, this.isGuidanceTask);
}