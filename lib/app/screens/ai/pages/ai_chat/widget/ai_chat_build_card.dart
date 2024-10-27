import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class AiChatBuildCard extends StatelessWidget {
  final List<dynamic> messages;
  const AiChatBuildCard({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    var filteredMessage =
        messages?.where((message) => message['role'] != 'system').toList();
    return Container(
      // Changed from Expanded to Container
      height:
          MediaQuery.of(context).size.height - 200, // Set an appropriate height
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: filteredMessage!.length,
        itemBuilder: (context, index) {
          final message = filteredMessage[index];
          final isBot = (message['role'] == 'assistant') ? true : false;

          return Align(
            alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
            child: Column(
              crossAxisAlignment:
                  (isBot) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment:
                      (isBot) ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: (isBot)
                      ? [
                          Image.asset(
                            'assets/images/splash_image.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 5),
                          Text('WEGLOBAL.AI')
                        ]
                      : [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              'https://i.pinimg.com/736x/61/f7/5e/61f75ea9a680def2ed1c6929fe75aeee.jpg',
                            ),
                          ),
                          SizedBox(width: 5),
                          Text('Вы')
                        ],
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 1),
                  decoration: BoxDecoration(
                    color: isBot ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: isBot
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Text(
                        message['content'],
                        style: TextStyle(
                          color: isBot ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      if (isBot && index == messages.length - 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            CustomButton(
                              text: 'Я не удовлетворен консультацией',
                              onTap: () {},
                              bgColor: Colors.white.withOpacity(0.4),
                            ),
                            SizedBox(height: 8),
                            CustomButton(
                              text: 'Закончить Чат',
                              onTap: () {},
                              textColor: AppColors.primary,
                              bgColor: Colors.white,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
