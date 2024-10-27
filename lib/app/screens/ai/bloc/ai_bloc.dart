import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/ai/service/ai_service.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  AiBloc() : super(AiInitial()) {
    var data = {};
    var currentChatData;
    on<AiEvent>((event, emit) async {
      if (event is AiLoad) {
        var prompts = await ApiClient.get('api/chats/prompts');
        if (prompts['success']) {
          data['prompts'] = prompts['data']['prompts'];
        }

        var history = await ApiClient.get('api/chats/history');
        if (history['success']) {
          data['history'] = history['data']['chatHistory'];
        }
        emit(AiLoaded(data: data, currentChatData: currentChatData));
      }
      if (event is AiNewChat) {
        currentChatData = null;
        var chatData = await ApiClient.post('api/chats/create',
            {"promptId": event.promptId, "languageCode": event.langCode});
        if (chatData['success']) {
          emit(AiLoaded(data: data, currentChatData: chatData['data']['chat']));
        }
      }
      if (event is AiChatHistorySetCurrentChat) {
        currentChatData = event.data;

        emit(AiLoaded(data: data, currentChatData: currentChatData));
      }
      if (event is AiChatUserSendMessage) {
        DateTime now = DateTime.now();
        String formattedDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now.toUtc());
        var req = await ApiClient.put('api/chats/update', {
          "chatId": event.chatId,
          "message": {"role": "user", "content": event.message}
        });

        if (req['success']) {
          currentChatData['messages'].add({
            'role': 'user',
            'content': event.message,
            'createdAt': formattedDate
          });
          emit(AiLoaded(data: data, currentChatData: currentChatData));
          List<dynamic> updatedMessages =
              currentChatData['messages'].map((message) {
            Map<String, dynamic> newMessage = Map.of(message);
            newMessage.remove("createdAt");
            return newMessage;
          }).toList();

          var response = await ChatGPT().sendMessageToChatGPT(updatedMessages);
          DateTime now = DateTime.now();
          String formattedDate2 =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now.toUtc());

          currentChatData['messages'].add({
            'role': 'assistant',
            'content': response,
            'createdAt': formattedDate2
          });
          var req2 = await ApiClient.put('api/chats/update', {
            "chatId": event.chatId,
            "message": {"role": "assistant", "content": response}
          });
          emit(AiLoaded(data: data, currentChatData: currentChatData));
        }
      }
    });
  }
}
