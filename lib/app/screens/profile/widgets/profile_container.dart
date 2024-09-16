import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileContainer extends StatelessWidget {
  final String text;
  final bool isUniversity;
  final double height;
  final Function() onTap;
  const ProfileContainer(
      {super.key,
      required this.text,
      required this.isUniversity,
      this.height = 144,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.onTheBlue2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                isUniversity
                    ? SvgPicture.asset(
                        'assets/icons/university.svg',
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        'assets/icons/career.svg',
                        width: 24,
                        height: 24,
                      ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/arrow-up-right.svg',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              text,
              style: AppTextStyle.heading2.copyWith(
                color: AppColors.blackForText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 24 / 20,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
