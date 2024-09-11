import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileLanguageCard extends StatelessWidget {
  final String asset;
  final String title;
  final bool isSelected;
  const ProfileLanguageCard(
      {super.key,
      required this.asset,
      required this.title,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:
              (isSelected) ? AppColors.primary.withOpacity(0.4) : Colors.white),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: AppTextStyle.heading2,
          )
        ],
      ),
    );
  }
}
