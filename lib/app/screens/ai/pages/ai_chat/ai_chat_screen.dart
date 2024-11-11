import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/ai/bloc/ai_bloc.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_build_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_question_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_start_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat_history/ai_chat_history_screen.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppbar(
          title: 'WeGlobal.ai',
          withBackButton: true,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<AiBloc, AiState>(
                  builder: (context, state) {
                    if (state is AiLoaded) {
                      return (state.currentChatData != null)
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 167.0),
                              child: AiChatBuildCard(
                                  isLoading: state.isGptThinking,
                                  messages: state.currentChatData['messages']),
                            )
                          : Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<AiBloc, AiState>(builder: (context, state) {
            if (state is AiLoaded) {
              return (state.currentChatData != null)
                  ? (state.currentChatData['messages'].length >= 20)
                      ? SizedBox()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: (Platform.isIOS) ? 45 : 10,
                                top: 10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 241),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: TextField(
                                      enabled:
                                          (!state.isGptThinking) ? true : false,
                                      controller: message,
                                      decoration: InputDecoration(
                                        hintText:
                                            LocaleKeys.enter_text.tr() + '...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    if (!state.isGptThinking) {
                                      BlocProvider.of<AiBloc>(context)
                                        ..add(AiChatUserSendMessage(
                                            message: message.text,
                                            chatId:
                                                state.currentChatData['_id']));
                                      message.text = '';
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: AppColors.primary,
                                    child: Icon(Icons.arrow_upward,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  : SizedBox();
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
