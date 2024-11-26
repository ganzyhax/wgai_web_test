import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wg_app/app/screens/colleges/bloc/colleges_bloc.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/containers/expanded_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CollegeFilterBottomSheet extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;
  final String collegeCode;

  const CollegeFilterBottomSheet({
    super.key,
    required this.onFilterApplied,
    required this.collegeCode,
  });

  @override
  State<CollegeFilterBottomSheet> createState() =>
      _CollegeFilterBottomSheetState();
}

class _CollegeFilterBottomSheetState extends State<CollegeFilterBottomSheet> {
  bool isDormitorySwitchOn = false;
  String? selectedRegion;
  String? selectedRegionId;
  var selectedSpecialites;
  String? selectedSpecialitesString;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegesBloc, CollegesState>(
      builder: (context, state) {
        if (state is CollegesLoaded) {
          return _buildFilterContent(context, state.colleges);
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.46,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildFilterContent(BuildContext context, List colleges) {
    var specialties = colleges
            .expand(
              (u) {
                // Ensure that 'specialties' is iterable (e.g., List)
                var specialtiesList =
                    u['specialties'] is List ? u['specialties'] : [];
                // Use 'where' to filter out items with null 'name'
                return specialtiesList.where((s) => s['name'] != null);
              },
            )
            .toSet() // Convert to Set to eliminate duplicates
            .toList() // Convert back to List
        ??
        []; // Default to empty list if null

    List<Map<String, dynamic>> regions = colleges
            ?.where((u) => u['regionName'] != null && u['regionId'] != null)
            .map((u) => {
                  'regionName': u['regionName'][context.locale.languageCode],
                  'regionId': u['regionId']
                })
            .toSet() // Remove duplicates based on the entire map
            .toList() ??
        [];
    //udalenie duplicates
    List<Map<String, dynamic>> uniqueRegions = [];
    final Set<String> regionIds = {};

    for (var region in regions) {
      if (!regionIds.contains(region['regionId'])) {
        regionIds.add(region['regionId']);
        uniqueRegions.add(region);
      }
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 66),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildFilterOption(
                context,
                'Регион',
                (selectedRegion == null)
                    ? 'all_regions'.tr()
                    : selectedRegion.toString(),
                uniqueRegions,
                (region) {
                  setState(() {
                    selectedRegion = region['regionName'];
                    selectedRegionId = region['regionId'].toString();
                  });
                },
                true,
              ),
              const SizedBox(height: 16),
              _buildFilterOption(
                context,
                LocaleKeys.specialities.tr(),
                selectedSpecialitesString != null &&
                        selectedSpecialitesString!.isNotEmpty
                    ? selectedSpecialitesString!
                    : 'choose'.tr(),
                specialties
                    .map((s) => s['name'][context.locale.languageCode])
                    .toList(),
                (selectedSpecialty) {
                  setState(() {
                    var specialtyObj = specialties.firstWhere((s) =>
                        s['name'][context.locale.languageCode] ==
                        selectedSpecialty);

                    selectedSpecialites = [specialtyObj];
                    selectedSpecialitesString = selectedSpecialty;
                  });
                },
                false,
              ),
              const SizedBox(height: 16),
              _buildToggleOption(
                context,
                'Общежитие',
                isDormitorySwitchOn,
                (val) {
                  setState(() {
                    isDormitorySwitchOn = val;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'apply'.tr(),
                onTap: () {
                  List<dynamic> appliedFilters = [];

                  if (selectedRegion != null && selectedRegion!.isNotEmpty) {
                    appliedFilters.add({
                      'regionName': selectedRegion,
                      'regionId': selectedRegionId
                    });
                  }

                  if (selectedSpecialites != null &&
                      selectedSpecialites!.isNotEmpty) {
                    appliedFilters.add(
                        '${selectedSpecialites!.map((e) => e['name'][context.locale.languageCode]).join(', ')}');
                  }

                  if (isDormitorySwitchOn) {
                    appliedFilters.add('Общежитие');
                  }

                  widget.onFilterApplied(appliedFilters);

                  context.read<CollegesBloc>().add(CollegesLoadByFilters(
                        universityCode: widget.collegeCode,
                        regionId: selectedRegionId,
                        specialities: selectedSpecialites,
                        hasDormitory: isDormitorySwitchOn,
                      ));

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'filter'.tr(),
          style: AppTextStyle.titleHeading.copyWith(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            context.read<CollegesBloc>().add(CollegesResetFilter());
            Navigator.pop(context);
          },
          child: Text(
            'reset_filters'.tr(),
            style: AppTextStyle.bodyText.copyWith(
              color: AppColors.exit,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.exit,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOption(
    BuildContext context,
    String title,
    String containerTitle,
    List<dynamic> options,
    Function(dynamic) onOptionSelected,
    bool isRegion,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.bodyText.copyWith(color: Colors.black),
        ),
        const Spacer(),
        ExpandedContainer(
          title: containerTitle,
          onTap: () {},
          items: options.map((option) {
            return isRegion
                ? option['regionName'].toString()
                : option.toString();
          }).toList(),
          onItemSelected: (selectedOptionName) {
            if (isRegion) {
              final selectedOption = options.firstWhere(
                (option) => option['regionName'] == selectedOptionName,
              );
              onOptionSelected(selectedOption);
            } else {
              onOptionSelected(selectedOptionName);
            }
          },
        ),
      ],
    );
  }

  Widget _buildToggleOption(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onToggle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.bodyText.copyWith(color: Colors.black),
        ),
        FlutterSwitch(
          value: value,
          onToggle: onToggle,
          width: 51,
          height: 31,
          toggleSize: 27,
          borderRadius: 20,
          padding: 4.0,
          activeColor: AppColors.actionGreen,
          inactiveColor: AppColors.actionFill,
        ),
      ],
    );
  }
}
