import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ClusterContainer extends StatelessWidget {
  final String icon;
  final String title;

  const ClusterContainer({
    super.key,
    required this.icon,
    required this.title,
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
        ],
      ),
    );
  }
}
