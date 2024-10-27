import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/widget/ai_chat_question_card.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiChatStartCard extends StatelessWidget {
  const AiChatStartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top Section
        Column(
          children: [
            SizedBox(height: 15),
            Center(
              child: Image.asset(
                'assets/images/splash_image.png',
                width: 140,
                height: 140,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                LocaleKeys.hello.tr() + ' ' + 'Name!',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'Задайте мне вопрос!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),

        // Suggested Section and ListView
        Padding(
          padding: const EdgeInsets.only(bottom: 65.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Suggested',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: AiChatQuestionCard(
                      text:
                          'Hey! Do you wanna see new robotics? Hey! Do you wanna see new robotics?',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
