import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class AtlasContainer extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  const AtlasContainer({
    super.key,
    required this.index,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onTheBlue2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. $title',
            style: AppTextStyle.heading2
                .copyWith(color: AppColors.calendarTextColor),
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: AppTextStyle.bodyText
                .copyWith(color: AppColors.calendarTextColor),
          ),
        ],
      ),
    );
  }
}
