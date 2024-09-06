import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniComplete extends StatelessWidget {
  final IconData icon;
  final String title;
  final String code;
  final String description;
  final bool hasMilitaryDept;
  final bool hasDormitory;
  final String type;

  const UniComplete({
    super.key,
    required this.icon,
    required this.code,
    required this.title,
    required this.description,
    required this.hasDormitory,
    required this.hasMilitaryDept,
    required this.type,
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
          const SizedBox(height: 8),
          Text(
            'Код',
            style:
                AppTextStyle.heading3.copyWith(color: AppColors.blackForText),
          ),
          Text(
            code,
            style:
                AppTextStyle.heading3.copyWith(color: AppColors.blackForText),
          ),
          const SizedBox(height: 8),
          Text(
            'Краткое описание',
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Text(
            description,
            style: AppTextStyle.bodyTextVerySmall
                .copyWith(color: AppColors.blackForText),
          ),
          const SizedBox(height: 16),
          UniversitiesTypesContainer(
            hasDormitory: hasDormitory,
            hasMilitaryDept: hasMilitaryDept,
            icon: icon,
            type: type,
          )
        ],
      ),
    );
  }
}

class UniversitiesTypesContainer extends StatelessWidget {
  final bool hasMilitaryDept;
  final bool hasDormitory;
  final String type;
  final IconData icon;

  const UniversitiesTypesContainer({
    super.key,
    required this.hasDormitory,
    required this.hasMilitaryDept,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onTheWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                PhosphorIcon(
                  PhosphorIconsBold.bank,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Тип',
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                Text(
                  type,
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            height: 0.5,
            decoration: BoxDecoration(color: AppColors.filterGray),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                PhosphorIcon(
                  PhosphorIconsBold.shieldChevron,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Военная кафедра',
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                if (hasMilitaryDept)
                  Text(
                    hasMilitaryDept ? 'Да' : 'Нет',
                    style: AppTextStyle.bodyTextSmall.copyWith(
                        color: hasMilitaryDept
                            ? AppColors.actionGreen
                            : AppColors.exit),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            height: 0.5,
            decoration: BoxDecoration(color: AppColors.filterGray),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/dormitory.svg',
                  color: AppColors.primary,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Общежитие',
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                if (hasDormitory)
                  Text(
                    hasDormitory ? 'Да' : 'Нет',
                    style: AppTextStyle.bodyTextSmall.copyWith(
                        color: hasDormitory
                            ? AppColors.actionGreen
                            : AppColors.exit),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
