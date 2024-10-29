part of 'ai_bloc.dart';

@immutable
sealed class AiEvent {}

final class AiLoad extends AiEvent {}

final class AiNewChat extends AiEvent {
  final String promptId;
  final String langCode;
  AiNewChat({required this.promptId, required this.langCode});
}

final class AiChatHistorySetCurrentChat extends AiEvent {
  final data;
  AiChatHistorySetCurrentChat({required this.data});
}

final class AiChatUserSendMessage extends AiEvent {
  final String message;
  final String chatId;
  AiChatUserSendMessage({required this.message, required this.chatId});
}
