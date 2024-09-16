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

class FilterBottomSheet extends StatefulWidget {
  final Function(List<String>) onFilterApplied;
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
  List<SpecialtiesUni>? selectedSpecialites;

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

  Widget _buildFilterContent(BuildContext context, List<Universities>? universities) {
    print('Building Filter Content');
    List<String> regions =
        universities?.where((u) => u.regionName != null).map((u) => u.regionName!.getLocalizedString(context)).toSet().toList() ??
            [];
    List<String> specialties = universities
            ?.expand((u) => (u.specialties ?? []).where((s) => s.name != null).map((s) => s.name!.getLocalizedString(context)))
            .toSet()
            .toList() ??
        [];

    print('Regions: $regions');
    print('Specialties: $specialties');

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 66),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildFilterOption(context, 'Регион', 'all_regions'.tr(), regions, (region) {
            setState(() {
              selectedRegion = region;
            });
          }),
          const SizedBox(height: 16),
          _buildFilterOption(
              context,
              'Специальности',
              selectedSpecialites != null && selectedSpecialites!.isNotEmpty
                  ? selectedSpecialites!.map((s) => s.name?.getLocalizedString(context)).join(', ')
                  : 'choose'.tr(),
              specialties, (specialty) {
            setState(() {
              print(specialty.toString());
              selectedSpecialites = [SpecialtiesUni(name: Name(specialty.toString()))];
            });
          }),
          const SizedBox(height: 16),
          _buildToggleOption(context, 'Общежитие', isDormitorySwitchOn, (val) {
            setState(() {
              isDormitorySwitchOn = val;
            });
          }),
          const SizedBox(height: 16),
          _buildToggleOption(context, 'Военная Кафедра', isMilitarySwitchOn, (val) {
            setState(() {
              isMilitarySwitchOn = val;
            });
          }),
          const SizedBox(height: 16),
          CustomButton(
            text: 'apply'.tr(),
            onTap: () {
              print('Applying Filters:');
              print('Region: $selectedRegion');
              print('Specialties: $selectedSpecialites');
              print('Dormitory: $isDormitorySwitchOn');
              print('Military Dept: $isMilitarySwitchOn');
              List<String> appliedFilters = [];

              if (selectedRegion != null && selectedRegion!.isNotEmpty) {
                appliedFilters.add('$selectedRegion');
              }
              if (selectedSpecialites != null && selectedSpecialites!.isNotEmpty) {
                appliedFilters
                    .add('Specialty: ${selectedSpecialites!.map((e) => e.name?.getLocalizedString(context)).join(', ')}');
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
                    regionId: selectedRegion ?? '',
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
    Function(String) onOptionSelected,
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
          items: options.map((option) => option.toString()).toList(),
          onItemSelected: (selectedOption) {
            onOptionSelected(selectedOption);
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
