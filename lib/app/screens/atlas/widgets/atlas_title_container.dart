import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class AtlasTitleContainer extends StatelessWidget {
  final String icon;
  final String title;
  final String titleDescription;
  final String description;

  const AtlasTitleContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.titleDescription,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final IconData? resolvedIcon = myIconMap[icon];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (resolvedIcon != null)
                PhosphorIcon(
                  resolvedIcon,
                  color: AppColors.primary,
                  size: 48,
                ),
              SizedBox(width: 16),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyle.heading3
                      .copyWith(color: AppColors.blackForText),
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          Text(
            titleDescription,
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Text(
            description,
            style: AppTextStyle.bodyTextVerySmall
                .copyWith(color: AppColors.blackForText),
          ),
        ],
      ),
    );
  }
}
