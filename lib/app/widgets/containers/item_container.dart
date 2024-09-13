import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ItemContainer extends StatelessWidget {
  final String text;
  final String icon;
  final Color? color;
  final TextStyle? textStyle;
  final Function() onTap;
  final double borderRadius;
  final double padding;
  final double range;
  const ItemContainer({
    super.key,
    required this.text,
    required this.icon,
    this.color,
    this.textStyle = AppTextStyle.bodyTextSmall,
    this.borderRadius = 8,
    this.padding = 0,
    this.range = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: textStyle?.copyWith(color: AppColors.gray333333),
            ),
            SizedBox(width: range),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: onTap,
              icon: SvgPicture.asset(icon),
            ),
          ],
        ),
      ),
    );
  }
}
