import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniSpecialContainer extends StatelessWidget {
  final Function() onTap;
  final String codeNumber;
  final String title;
  final String subject;
  final int grantScore;
  final int paidScore;
  const UniSpecialContainer({
    super.key,
    required this.onTap,
    required this.codeNumber,
    required this.title,
    required this.subject,
    required this.grantScore,
    required this.paidScore,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  codeNumber,
                  style: AppTextStyle.heading3.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.heading3.copyWith(color: AppColors.calendarTextColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subject,
                    style: AppTextStyle.bodyTextVerySmall.copyWith(color: AppColors.grayForText),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Проходной балл (грант): $grantScore',
                    style: AppTextStyle.bodyTextVerySmall.copyWith(color: AppColors.grayForText),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Проходной балл (Платный): $paidScore',
                    style: AppTextStyle.bodyTextVerySmall.copyWith(color: AppColors.grayForText),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              'assets/icons/caret-right.svg',
              height: 20,
              width: 20,
              color: AppColors.calendarTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
