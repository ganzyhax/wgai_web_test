import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CareerStorageContainer extends StatelessWidget {
  final String title;

  const CareerStorageContainer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var data = BookmarkData().getItems(AppHiveConstants.professions);
    log(data.toString());
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
              SvgPicture.asset('assets/icons/chalkboard_teacher.svg'),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.heading3
                      .copyWith(color: AppColors.calendarTextColor),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/caret-right.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'View All',
            bgColor: AppColors.background,
            textColor: Colors.black,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
