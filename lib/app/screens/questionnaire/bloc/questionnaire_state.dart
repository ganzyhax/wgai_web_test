part of 'questionnaire_bloc.dart';

@immutable
sealed class QuestionnaireState {}

class QuestionnaireInitial extends QuestionnaireState {}

class QuestionnaireLoadingState extends QuestionnaireState {}

class QuestionnaireSuccessState extends QuestionnaireState {
  final List<Problems> questions;
  final int currentIndex;
  final List<String> selectedAnswers;
  final String questionnaireType;
  final List<Problems> portraitImage;
  final List<Problems> isMultipleChoice;

  QuestionnaireSuccessState({
    required this.questions,
    required this.currentIndex,
    required this.selectedAnswers,
    required this.questionnaireType,
    required this.portraitImage,
    required this.isMultipleChoice,
  });

  QuestionnaireSuccessState copyWith({
    List<Problems>? questions,
    int? currentIndex,
    List<String>? selectedAnswers,
    String? questionnaireType,
    String? description,
    List<Problems>? portraitImage,
    List<Problems>? isMultipleChoice,
  }) {
    return QuestionnaireSuccessState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      questionnaireType: questionnaireType ?? this.questionnaireType,
      portraitImage: portraitImage ?? this.portraitImage,
      isMultipleChoice: isMultipleChoice ?? this.isMultipleChoice,
    );
  }
}

class QuestionnaireCompletedState extends QuestionnaireState {}

class QuestionnaireErrorState extends QuestionnaireState {
  final String errorMessage;

  QuestionnaireErrorState(this.errorMessage);
}
