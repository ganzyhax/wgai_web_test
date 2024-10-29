part of 'ai_bloc.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoaded extends AiState {
  final data;
  final currentChatData;
  final String userName;
  final bool isGptThinking;
  AiLoaded(
      {required this.data,
      required this.isGptThinking,
      required this.currentChatData,
      required this.userName});
}
