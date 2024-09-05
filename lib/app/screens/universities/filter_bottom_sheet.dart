import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/universities_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isRegionSwitchOn = false;
  bool isMilitarySwitchOn = false;
  String? selectedRegion;
  List<Specialties>? selectedSpecialites;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 66),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Фильтр',
                style: AppTextStyle.titleHeading.copyWith(color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  context.read<UniversitiesBloc>().add(ResetFilters());
                },
                child: Text(
                  'Сбросить Фильтры',
                  style: AppTextStyle.bodyText.copyWith(
                    color: AppColors.exit,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.exit,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Пожалуйста выберите, как вы хотите настроить ваш аккаунт',
            style: AppTextStyle.bodyText.copyWith(color: AppColors.grayForText),
          ),
          const SizedBox(height: 16),
          _builderFilterOption(
            context,
            'Регион',
            true,
            Text(
              'Все регионы',
              style: AppTextStyle.heading3
                  .copyWith(color: AppColors.calendarTextColor),
            ),
            () {},
          ),
          const SizedBox(height: 16),
          _builderFilterOption(
            context,
            'Специальности',
            true,
            Text(
              'Выбрать',
              style: AppTextStyle.heading3
                  .copyWith(color: AppColors.calendarTextColor),
            ),
            () {},
          ),
          const SizedBox(height: 16),
          _builderFilterOption(
            context,
            'Регион',
            false,
            Text(
              'Общежитие',
              style: AppTextStyle.heading3
                  .copyWith(color: AppColors.calendarTextColor),
            ),
            () {},
            isSwitchOn: isRegionSwitchOn,
            onToggle: (bool val) {
              setState(() {
                isRegionSwitchOn = val;
              });
            },
          ),
          const SizedBox(height: 16),
          _builderFilterOption(
            context,
            'Военная Кафедра',
            false,
            Text(
              'Все регионы',
              style: AppTextStyle.heading3
                  .copyWith(color: AppColors.calendarTextColor),
            ),
            () {},
            isSwitchOn: isMilitarySwitchOn,
            onToggle: (bool val) {
              setState(() {
                isMilitarySwitchOn = val;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Применить',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _builderFilterOption(
    BuildContext context,
    String title,
    bool? isExpanded,
    Widget expandedTitle,
    Function? onTap, {
    bool? isSwitchOn,
    void Function(bool)? onToggle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.bodyText.copyWith(color: Colors.black),
        ),
        if (isExpanded == true)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.filterGray,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                expandedTitle,
                SizedBox(width: 4),
                SvgPicture.asset('assets/icons/expand_down.svg')
              ],
            ),
          )
        else if (isSwitchOn != null && onToggle != null)
          FlutterSwitch(
            value: isSwitchOn,
            onToggle: onToggle,
            width: 51,
            height: 31,
            toggleSize: 27,
            borderRadius: 20,
            padding: 4.0,
            activeColor: AppColors.actionGreen,
            inactiveColor: AppColors.actionFill,
          )
      ],
    );
  }
}
