part of 'questionnaire_bloc.dart';

@immutable
abstract class QuestionnaireState {}

class QuestionnaireInitial extends QuestionnaireState {}

class QuestionnaireLoadingState extends QuestionnaireState {}

class QuestionnaireSuccessState extends QuestionnaireState {
  final List<Problems> questions;
  final int currentIndex;
  final List<int>
      selectedAnswerIndices; // Changed from List<String> to List<int>
  final String questionnaireTitle;
  final List<Problems> portraitImage;
  final List<Problems> isMultipleChoice;

  QuestionnaireSuccessState({
    required this.questions,
    required this.currentIndex,
    required this.selectedAnswerIndices,
    required this.questionnaireTitle,
    required this.portraitImage,
    required this.isMultipleChoice,
  });

  QuestionnaireSuccessState copyWith({
    List<Problems>? questions,
    int? currentIndex,
    List<int>?
        selectedAnswerIndices, // Changed from List<String>? to List<int>?
    String? questionnaireTitle,
    List<Problems>? portraitImage,
    List<Problems>? isMultipleChoice,
  }) {
    return QuestionnaireSuccessState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswerIndices:
          selectedAnswerIndices ?? this.selectedAnswerIndices,
      questionnaireTitle: questionnaireTitle ?? this.questionnaireTitle,
      portraitImage: portraitImage ?? this.portraitImage,
      isMultipleChoice: isMultipleChoice ?? this.isMultipleChoice,
    );
  }
}

class QuestionnaireCompletedState extends QuestionnaireState {
  final List<List<int>> answers;
  QuestionnaireCompletedState(this.answers);
}

class QuestionnaireSubmittedState extends QuestionnaireState {}

class QuestionnaireErrorState extends QuestionnaireState {
  final String errorMessage;

  QuestionnaireErrorState(this.errorMessage);
}

class QuestionnaireSetLocalData extends QuestionnaireState {
  List<Map<String, dynamic>> data;
  QuestionnaireSetLocalData({required this.data});
}
