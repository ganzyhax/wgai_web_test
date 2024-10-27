import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class UniComplete extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String code;
  final String? description;
  final bool? hasMilitaryDept;
  final bool? hasDormitory;
  final bool? isUnivesity;
  final String? education;
  final String? type;

  const UniComplete({
    super.key,
    this.icon,
    required this.code,
    required this.title,
    this.description,
    this.hasDormitory,
    this.hasMilitaryDept,
    this.type,
    this.isUnivesity,
    this.education,
  });

  @override
  Widget build(BuildContext context) {
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
              PhosphorIcon(
                isUnivesity == true
                    ? PhosphorIconsBold.bank
                    : PhosphorIconsBold.chalkboardTeacher,
                color: AppColors.primary,
                size: 48,
              ),
              const SizedBox(width: 16),
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
            LocaleKeys.code.tr(),
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
            isUnivesity == true
                ? LocaleKeys.short_description.tr()
                : LocaleKeys.all_subjects.tr(),
            style: AppTextStyle.interW600S12
                .copyWith(color: AppColors.blackForText),
          ),
          Text(
            description ?? '',
            style: AppTextStyle.bodyTextVerySmall
                .copyWith(color: AppColors.blackForText),
          ),
          const SizedBox(height: 16),
          if (isUnivesity == true)
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
  final bool? hasMilitaryDept;
  final bool? hasDormitory;
  final String? type;
  final IconData? icon;

  const UniversitiesTypesContainer({
    super.key,
    this.hasDormitory,
    this.hasMilitaryDept,
    this.icon,
    this.type,
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
                const PhosphorIcon(
                  PhosphorIconsBold.bank,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  LocaleKeys.type.tr(),
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                Text(
                  type ?? '',
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            height: 0.5,
            decoration: const BoxDecoration(color: AppColors.filterGray),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsBold.shieldChevron,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  LocaleKeys.military_department.tr(),
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                if (hasMilitaryDept == true)
                  Text(
                    hasMilitaryDept == true
                        ? LocaleKeys.yes.tr()
                        : LocaleKeys.no.tr(),
                    style: AppTextStyle.bodyTextSmall.copyWith(
                        color: hasMilitaryDept == true
                            ? AppColors.actionGreen
                            : AppColors.exit),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            height: 0.5,
            decoration: const BoxDecoration(color: AppColors.filterGray),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/dormitory.svg',
                  color: AppColors.primary,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  LocaleKeys.dormitory.tr(),
                  style: AppTextStyle.bodyTextSmall
                      .copyWith(color: AppColors.blackForText),
                ),
                const Spacer(),
                if (hasDormitory == true)
                  Text(
                    hasDormitory == true
                        ? LocaleKeys.yes.tr()
                        : LocaleKeys.no.tr(),
                    style: AppTextStyle.bodyTextSmall.copyWith(
                        color: hasDormitory == true
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
