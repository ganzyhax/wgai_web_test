import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniContainers extends StatelessWidget {
  final String? codeNumber;
  final dynamic icon;
  final String title;
  final String? firstDescription;
  final int? secondDescription;
  final Function() onTap;
  final bool showIcon;
  const UniContainers({
    super.key,
    this.icon,
    this.codeNumber,
    required this.title,
    this.firstDescription,
    this.secondDescription,
    required this.onTap,
    this.showIcon = false,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (showIcon && icon != null)
                  _buildIconWidget(icon)
                else
                  Text(
                    codeNumber ?? '',
                    style: AppTextStyle.heading3
                        .copyWith(color: AppColors.primary),
                  ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    title,
                    style: AppTextStyle.heading3
                        .copyWith(color: AppColors.calendarTextColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      firstDescription ?? '',
                      style: AppTextStyle.bodyTextVerySmall
                          .copyWith(color: AppColors.grayForText),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (secondDescription != null)
                    Text(
                      'Специальности: $secondDescription',
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

  Widget _buildIconWidget(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color: AppColors.primary);
    } else if (icon is PhosphorIconData) {
      return PhosphorIcon(icon, color: AppColors.primary);
    } else {
      return Container();
    }
  }
}
