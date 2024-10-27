import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class AiChatBuildCard extends StatelessWidget {
  final List<Map<String, dynamic>> messages;
  const AiChatBuildCard({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isBot = message['isBot'];

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
                          SizedBox(
                            width: 5,
                          ),
                          Text('WEGLOBAL.AI')
                        ]
                      : [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg',
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Mukhammed Yeraliev')
                        ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                        message['text'],
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
