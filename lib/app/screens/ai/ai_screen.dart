import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/ai/bloc/ai_bloc.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/ai_chat_screen.dart';
import 'package:wg_app/app/screens/ai/widgets/ai_chat_history_card.dart';
import 'package:wg_app/app/screens/ai/widgets/ai_chat_title_card.dart';

import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:wg_app/utils/fcm_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final FCMService _fcmService = FCMService();

  @override
  void initState() {
    super.initState();
    _fcmService.initializeAfterLogin(context);
    // Handle the case when the app is opened via a notification click
    _fcmService.handleInitialMessage(context);

    // Listen for notification taps when the app is in the background/foreground
    _fcmService.configureNotificationActions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppbar(
          title: '',
          titleWidget: Row(
            children: [
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 30.0,
                  ),
                );
              }),
            ],
          ),
          withBackButton: false,
        ),
      ),
      drawer: Drawer(
        child: BlocBuilder<AiBloc, AiState>(
          builder: (context, state) {
            if (state is AiLoaded) {
              return ListView(
                padding: EdgeInsets.only(
                    left: 10, top: (Platform.isIOS) ? 80 : 35, right: 10),
                children: <Widget>[
                  Text(
                    LocaleKeys.all_chats.tr(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: state.data['history'].map<Widget>((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<AiBloc>(context)
                              ..add(AiChatHistorySetCurrentChat(data: e));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AiChatScreen()),
                            );
                          },
                          child: AiChatHistoryCardNew(
                            date: e['messages'][e['messages'].length - 1]
                                ['createdAt'],
                            title: e['messages'][e['messages'].length - 1]
                                ['content'],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      backgroundColor: AppColors.background,
      body: BlocListener<AiBloc, AiState>(
        listener: (context, state) {
          if (state is AiOpenChat) {
            log('ASDASDASD');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AiChatScreen()),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<AiBloc, AiState>(
              builder: (context, state) {
                if (state is AiLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/splash_image.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          LocaleKeys.good_afternoon.tr() +
                              ', ' +
                              state.userName.toString(),
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[500]),
                        ),
                      ),
                      Center(
                        child: Text(
                          LocaleKeys.ask_me_question.tr() + '!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        LocaleKeys.topics.tr(),
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: state.data['prompts'].map<Widget>((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: AiChatTitleCard(
                              data: e,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
