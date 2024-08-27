import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileStorageContainer extends StatelessWidget {
  final String title;
  final bool showLeftIcon;
  final bool isMyCareer;
  final bool showRightIcon;
  final bool showContainer;
  final String buttonTitle;
  final String description;
  final VoidCallback onButtonTap;
  const ProfileStorageContainer({
    super.key,
    required this.title,
    this.showLeftIcon = false,
    this.showRightIcon = false,
    required this.buttonTitle,
    this.isMyCareer = false,
    this.showContainer = false,
    required this.description,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showLeftIcon)
                isMyCareer
                    ? SvgPicture.asset('assets/icons/chalkboard_teacher.svg')
                    : SvgPicture.asset('assets/icons/notebook.svg'),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.heading3
                      .copyWith(color: AppColors.calendarTextColor),
                ),
              ),
              if (showRightIcon)
                SvgPicture.asset(
                  'assets/icons/caret-right.svg',
                  width: 20,
                  height: 20,
                ),
              if (showContainer)
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.onTheWhite,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Математика -Физика',
                    style: TextStyle(
                      fontFamily: kInterFontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackForText,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Image.asset('assets/images/folder.png'),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTextStyle.bodyText.copyWith(
              color: AppColors.grayForText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: buttonTitle,
            onTap: onButtonTap,
          ),
        ],
      ),
    );
  }
}