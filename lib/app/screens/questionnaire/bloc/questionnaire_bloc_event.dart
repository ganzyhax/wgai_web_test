part of 'questionnaire_bloc_bloc.dart';

@immutable
sealed class QuestionnaireBlocEvent {}

class LoadQuestions extends QuestionnaireBlocEvent {}

class AnswersQuestions extends QuestionnaireBlocEvent {
  final String answer;
  AnswersQuestions(this.answer);
}

class NextQuestion extends QuestionnaireBlocEvent {}
