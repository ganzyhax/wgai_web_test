part of 'ai_bloc.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoaded extends AiState {
  final data;
  final currentChatData;
  final String userName;
  AiLoaded(
      {required this.data,
      required this.currentChatData,
      required this.userName});
}
