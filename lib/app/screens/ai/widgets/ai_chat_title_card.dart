import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/ai/bloc/ai_bloc.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:wg_app/main.dart';

import '../pages/ai_chat/ai_chat_screen.dart';

class AiChatTitleCard extends StatelessWidget {
  final data;
  const AiChatTitleCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String langCode = context.locale.languageCode;
        BlocProvider.of<AiBloc>(context)
          ..add(AiNewChat(promptId: data['_id'], langCode: langCode));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AiChatScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 228, 227, 227)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              'assets/images/splash_image.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.36,
                  child: Text(
                    data['title'][context.locale.languageCode],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.36,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    data['description'][context.locale.languageCode],
                    style: TextStyle(fontSize: 17, color: Colors.grey[500]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
