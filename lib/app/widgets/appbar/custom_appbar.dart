import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final bool withBackButton;
  final List<Widget>? actions;
  final Function()? onBackClicked;
  const CustomAppbar(
      {super.key,
      required this.title,
      this.titleWidget,
      this.onBackClicked,
      required this.withBackButton,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(40, 40),
      child: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: withBackButton,
          actions: (actions != null) ? actions : null,
          leading: (withBackButton)
              ? IconButton(
                  onPressed: (onBackClicked == null)
                      ? () {
                          Navigator.pop(context);
                        }
                      : onBackClicked,
                  icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
                )
              : null,
          title: (titleWidget == null)
              ? Text(
                  title,
                  style: AppTextStyle.titleHeading
                      .copyWith(color: AppColors.blackForText),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  textScaler: TextScaler.linear(1),
                )
              : titleWidget),
    );
  }
}
