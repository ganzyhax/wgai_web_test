part of 'questionnaire_bloc.dart';

@immutable
sealed class QuestionnaireState {}

final class QuestionnaireBlocInitial extends QuestionnaireState {}

class QuestionnaireLoadingState extends QuestionnaireState {}

class QuestionnaireSuccessState extends QuestionnaireState {
  final List<Question> questions;
  final int currentIndex;
  final String? selectedAnswer;
  QuestionnaireSuccessState(
      {required this.questions,
      required this.currentIndex,
      this.selectedAnswer});

  QuestionnaireSuccessState copyWith({
    List<Question>? questions,
    int? currentIndex,
    String? selectedAnswer,
  }) {
    return QuestionnaireSuccessState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}

class QuestionnaireErrorState extends QuestionnaireState {
  final String errorMessage;

  QuestionnaireErrorState(this.errorMessage);
}

class QuestionnaireCompletedState extends QuestionnaireState {}
