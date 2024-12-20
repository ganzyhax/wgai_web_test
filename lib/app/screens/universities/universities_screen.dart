import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/filter_bottom_sheet.dart';
import 'package:wg_app/app/screens/universities/universities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/app/widgets/containers/item_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  List<dynamic> activeFilters = [];

  @override
  void initState() {
    super.initState();
    context.read<UniversitiesBloc>().add(LoadUniversities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(title: '', withBackButton: true)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.universities.tr(),
                  style: AppTextStyle.titleHeading
                      .copyWith(color: AppColors.blackForText),
                ),
                IconButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            final universityCode = '';
                            return FilterBottomSheet(
                              onFilterApplied: (filters) {
                                setState(() {
                                  activeFilters = filters;
                                });
                              },
                              universityCode: universityCode,
                            );
                          },
                        );
                      },
                    );
                    setState(() {});
                  },
                  icon: SvgPicture.asset('assets/icons/filter.svg'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActiveFilters(),
            const SizedBox(height: 12),
            BlocBuilder<UniversitiesBloc, UniversitiesState>(
              builder: (context, state) {
                if (state is UniversitiesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UniversitiesLoaded) {
                  return Column(
                    children: List.generate(
                      state.filteredUniversities?.length ?? 0,
                      (index) {
                        final university = state.filteredUniversities?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UniContainers(
                            codeNumber: university?.code ?? '',
                            title:
                                university?.name?.getLocalizedString(context) ??
                                    '',
                            firstDescription: university?.regionName
                                    ?.getLocalizedString(context) ??
                                '',
                            secondDescription:
                                university?.specialties?.length ?? 0,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UniversitiesCompleteScreen(
                                    universityId: university?.code ?? '',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is UniversitiesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
    return activeFilters.isNotEmpty
        ? Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeFilters.map((filter) {
              if (filter is Map<String, dynamic>) {
                if (filter.containsKey('regionName')) {
                  return ItemContainer(
                    text: filter['regionName'], // Display the region name
                    icon: 'assets/icons/x.svg',
                    color: AppColors.onTheBlue2,
                    onTap: () {
                      setState(() {
                        activeFilters.remove(filter);
                        context
                            .read<UniversitiesBloc>()
                            .add(LoadUniversities());
                      });
                    },
                  );
                }
              } else if (filter is String) {
                return ItemContainer(
                  text: filter, // Specialty or other filters as strings
                  icon: 'assets/icons/x.svg',
                  color: AppColors.onTheBlue2,
                  onTap: () {
                    setState(() {
                      activeFilters.remove(filter);
                      context.read<UniversitiesBloc>().add(LoadUniversities());
                    });
                  },
                );
              }
              return SizedBox.shrink();
            }).toList(),
          )
        : const SizedBox.shrink();
  }
}
