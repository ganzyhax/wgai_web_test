import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat/ai_chat_screen.dart';
import 'package:wg_app/app/screens/ai/widgets/ai_last_dialog_card.dart';
import 'package:wg_app/app/screens/ai/widgets/ai_questions_card.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppbar(
          title: 'WEGLOBAL.AI',
          withBackButton: true,
          actions: [
            Icon(Icons.notifications),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AiChatScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Icon(Icons.chat),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Image.asset(
                  'assets/images/splash_image.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  LocaleKeys.hello.tr() + ' ' + 'Name!',
                  style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Last dialogy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              AiLastDialogCard(
                title: 'Holland test',
                description:
                    'ALSKdjaslkdjsalkdjmas ALSKdjaslkdjsalkdjmas ALSKdjaslkdjsalkdjmas ALSKdjaslkdjsalkdjmas ',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'AI көмекшіге сұрақ қою...',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.2,
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AiQuestionsCard(
                          title: 'Adsadasdasdasasdasdasdasdd',
                          description:
                              'asdsadasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdsassd',
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
