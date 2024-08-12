part of 'questionnaire_bloc.dart';

@immutable
sealed class QuestionnaireState {}

final class QuestionnaireBlocInitial extends QuestionnaireState {}

class QuestionnaireLoadingState extends QuestionnaireState {}

class QuestionnaireSuccessState extends QuestionnaireState {
  final List<Problems> questions;
  final int currentIndex;
  final String? selectedAnswer;
  final String? testId;
  final int? timeLimit;
  final Titles? description;
  final String? thumbnail;

  QuestionnaireSuccessState({
    required this.questions,
    required this.currentIndex,
    this.selectedAnswer,
    required this.testId,
    required this.timeLimit,
    required this.description,
    required this.thumbnail,
  });

  QuestionnaireSuccessState copyWith({
    List<Problems>? questions,
    int? currentIndex,
    String? selectedAnswer,
    String? testId,
    int? timeLimit,
    Titles? description,
    String? thumbnail,
  }) {
    return QuestionnaireSuccessState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      testId: testId ?? this.testId,
      timeLimit: timeLimit ?? this.timeLimit,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}

class QuestionnaireErrorState extends QuestionnaireState {
  final String errorMessage;

  QuestionnaireErrorState(this.errorMessage);
}

class QuestionnaireCompletedState extends QuestionnaireState {}
