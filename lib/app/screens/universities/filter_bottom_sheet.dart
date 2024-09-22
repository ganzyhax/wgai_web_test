import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/containers/expanded_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;
  final String universityCode;

  const FilterBottomSheet({
    super.key,
    required this.onFilterApplied,
    required this.universityCode,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isDormitorySwitchOn = false;
  bool isMilitarySwitchOn = false;
  String? selectedRegion;
  String? selectedRegionId;
  List<SpecialtiesUni>? selectedSpecialites;
  String? selectedSpecialitesString;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniversitiesBloc, UniversitiesState>(
      builder: (context, state) {
        if (state is UniversitiesLoading) {
          return _buildLoadingIndicator();
        } else if (state is UniversitiesLoaded) {
          return _buildFilterContent(context, state.universities);
        } else {
          return const Center(child: Text('Failed to load filters'));
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

  Widget _buildFilterContent(
      BuildContext context, List<Universities>? universities) {
    List<SpecialtiesUni> specialties = universities
            ?.expand((u) => (u.specialties ?? []).where((s) => s.name != null))
            .toSet()
            .toList() ??
        [];

    List<Map<String, dynamic>> regions = universities
            ?.where((u) => u.regionName != null && u.regionId != null)
            .map((u) => {
                  'regionName': u.regionName!.getLocalizedString(context),
                  'regionId': u.regionId
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

    log(regions.length.toString());
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
                    .map((s) => s.name!.getLocalizedString(context))
                    .toList(),
                (selectedSpecialty) {
                  setState(() {
                    // Find the selected specialty from the actual list of specialties
                    SpecialtiesUni? specialtyObj = specialties.firstWhere((s) =>
                        s.name!.getLocalizedString(context) ==
                        selectedSpecialty);

                    selectedSpecialites = [
                      specialtyObj
                    ]; // Store the actual object
                    selectedSpecialitesString =
                        selectedSpecialty; // Store the string for UI
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
              _buildToggleOption(
                context,
                'Военная Кафедра',
                isMilitarySwitchOn,
                (val) {
                  setState(() {
                    isMilitarySwitchOn = val;
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
                        '${selectedSpecialites!.map((e) => e.name?.getLocalizedString(context)).join(', ')}');
                  }

                  if (isDormitorySwitchOn) {
                    appliedFilters.add('Общежитие');
                  }
                  if (isMilitarySwitchOn) {
                    appliedFilters.add('Военная кафедра');
                  }

                  widget.onFilterApplied(appliedFilters);

                  context.read<UniversitiesBloc>().add(LoadbyFilters(
                        universityCode: widget.universityCode,
                        regionId: selectedRegionId,
                        specialities: selectedSpecialites,
                        hasDormitory: isDormitorySwitchOn,
                        hasMilitaryDept: isMilitarySwitchOn,
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
            context.read<UniversitiesBloc>().add(ResetFilters());
            context.read<UniversitiesBloc>().add(LoadUniversities());
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
          items: (isRegion)
              ? options.map((option) {
                  // Display the regionName in the UI
                  return option['regionName'].toString();
                }).toList()
              : options.map((option) {
                  // Display as string for other types of options
                  return option.toString();
                }).toList(),
          onItemSelected: (selectedOptionName) {
            if (isRegion) {
              var selectedOption = options.firstWhere(
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
