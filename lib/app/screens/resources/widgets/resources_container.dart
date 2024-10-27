import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ResourcesContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String iconPath;
  final double height;
  final Function() onTap;
  const ResourcesContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconPath,
      this.height = 144,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whiteForText,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                        iconPath,
                        width: 24,
                        height: 24,
                        color: AppColors.blackForText,
                      ),
                const Spacer(),
                  Transform.rotate(
                  angle: 3.14159, // 180 degrees in radians
                  child: SvgPicture.asset(
                    'assets/icons/arrow-left.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: AppTextStyle.heading2.copyWith(
                color: AppColors.blackForText,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 24 / 20,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Text(
              subTitle,
              style: AppTextStyle.bodyText.copyWith(
                color: AppColors.grayForText,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
