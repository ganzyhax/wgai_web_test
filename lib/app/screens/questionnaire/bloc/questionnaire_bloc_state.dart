part of 'questionnaire_bloc_bloc.dart';

@immutable
sealed class QuestionnaireBlocState {}

final class QuestionnaireBlocInitial extends QuestionnaireBlocState {}

class QuestionnaireLoadingState extends QuestionnaireBlocState {}

class QuestionnaireSuccessState extends QuestionnaireBlocState {
  final List<QuestionnaireModel> questions;
  final int currentIndex;
  QuestionnaireSuccessState(
      {required this.questions, required this.currentIndex});
}

class QuestionnaireErrorState extends QuestionnaireBlocState {
  final String errorMessage;

  QuestionnaireErrorState(this.errorMessage);
}

class QuestionnaireCompletedState extends QuestionnaireBlocState {}
