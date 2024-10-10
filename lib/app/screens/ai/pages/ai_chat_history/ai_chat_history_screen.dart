import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/ai/pages/ai_chat_history/widgets/ai_chat_history_card.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiChatHistoryScreen extends StatelessWidget {
  const AiChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppbar(title: 'Чаты', withBackButton: true)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50, // Adjust height as needed
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFE9E9EF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search chat",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Все чаты',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AiChatHistoryCard(
                      title: 'Asdlkasjdlkasdjlkasjdlkasjdlk',
                      message: 'asdas12312312312312312312321dsad',
                      unreadedMessageCount: 2,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
