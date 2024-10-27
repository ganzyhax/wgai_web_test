part of 'test_bloc.dart';

@immutable
sealed class TestState {}

final class TestBlocInitial extends TestState {}

class TestLoadingState extends TestState {}

class TestSuccessState extends TestState {
  final List<Problems> questions;
  final int currentIndex;
  final String? selectedAnswer;
  final String? testType;
  final int? timeLimit;
  final Thumbnail? description;
  final Thumbnail? thumbnail;
  final String sId;

  TestSuccessState({
    required this.questions,
    required this.currentIndex,
    this.selectedAnswer,
    required this.testType,
    required this.timeLimit,
    required this.description,
    required this.thumbnail,
    required this.sId,
  });

  TestSuccessState copyWith({
    List<Problems>? questions,
    int? currentIndex,
    String? selectedAnswer,
    String? testType,
    int? timeLimit,
    Thumbnail? description,
    Thumbnail? thumbnail,
    String? sId,
  }) {
    return TestSuccessState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      testType: testType ?? this.testType,
      timeLimit: timeLimit ?? this.timeLimit,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      sId: sId ?? this.sId,
    );
  }
}

class TestErrorState extends TestState {
  final String errorMessage;

  TestErrorState(this.errorMessage);
}

class TestCompletedState extends TestState {
  // final String result;

  // TestCompletedState(this.result);
}
