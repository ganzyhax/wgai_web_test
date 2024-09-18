import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool withBackButton;
  const CustomAppbar(
      {super.key, required this.title, required this.withBackButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      automaticallyImplyLeading: withBackButton,
      leading: (withBackButton)
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
            )
          : null,
      title: Text(
        title, //Change
        style:
            AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        textScaler: TextScaler.linear(1),
      ),
    );
  }
}
