import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniContainers extends StatelessWidget {
  final String codeNumber;
  final String title;
  final String firstDescription;
  final String secondDescription;
  final Function() onTap;
  const UniContainers({
    super.key,
    required this.codeNumber,
    required this.title,
    required this.firstDescription,
    required this.secondDescription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  codeNumber,
                  style:
                      AppTextStyle.heading3.copyWith(color: AppColors.primary),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: AppTextStyle.heading3
                      .copyWith(color: AppColors.calendarTextColor),
                ),
              ],
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    firstDescription,
                    style: AppTextStyle.bodyTextVerySmall
                        .copyWith(color: AppColors.grayForText),
                  ),
                  Text(
                    secondDescription,
                    style: AppTextStyle.bodyTextVerySmall
                        .copyWith(color: AppColors.grayForText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
