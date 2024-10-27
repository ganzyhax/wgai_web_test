import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_build_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_question_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_start_card.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat_history/ai_chat_history_screen.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _messages = [
      {
        "text":
            "Адилет, вы уже задумывались о том, кем хотели бы стать в будущем?",
        "isBot": true
      },
      {
        "text": "Да, есть. Я хочу стать инженером, но не знаю каким именно",
        "isBot": false
      },
      {
        "text":
            "Отличный выбор, Адилет! Инженерия востребована. Что именно вас привлекает?",
        "isBot": true
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppbar(
          title: 'Чат с ИИ',
          withBackButton: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AiChatHistoryScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.menu),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (_messages.length == 0)
                      ? AiChatStartCard()
                      : AiChatBuildCard(messages: _messages)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 235, 241),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Введите сообщение...',
                          border: InputBorder.none,
                        ),
                      ),

                      // Send button
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
