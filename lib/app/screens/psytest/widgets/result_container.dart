import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ResultContainer extends StatelessWidget {
  final String title;
  const ResultContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ваш психотип:',
            style: AppTextStyle.bodyTextMiddle
                .copyWith(color: AppColors.onTheBlue2),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: kInterFontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
