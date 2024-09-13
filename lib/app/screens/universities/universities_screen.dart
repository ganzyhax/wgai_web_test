import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/filter_bottom_sheet.dart';
import 'package:wg_app/app/screens/universities/universities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/containers/item_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  List<String> activeFilters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'ВУЗ-ы'.tr(),
          style: AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            // Header and filter button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ВУЗ-ы'.tr(),
                  style: AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FilterBottomSheet(
                          onFilterApplied: (filters) {
                            setState(() {
                              activeFilters = filters;
                            });
                          },
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset('assets/icons/filter.svg'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Active Filters Section
            _buildActiveFilters(),
            const SizedBox(height: 12),
            // Universities List Section
            BlocBuilder<UniversitiesBloc, UniversitiesState>(
              builder: (context, state) {
                if (state is UniversitiesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UniversitiesLoaded) {
                  return Column(
                    children: List.generate(
                      state.universities?.length ?? 0,
                      (index) {
                        final university = state.universities?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UniContainers(
                            codeNumber: university?.code ?? '',
                            title: university?.name?.getLocalizedString(context) ?? '',
                            firstDescription: university?.regionName?.getLocalizedString(context) ?? '',
                            secondDescription: university?.specialties?.length ?? 0,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UniversitiesCompleteScreen(
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
              return ItemContainer(
                text: filter,
                icon: 'assets/icons/x.svg',
                color: AppColors.onTheBlue2,
                onTap: () {
                  setState(() {
                    activeFilters.remove(filter);
                    context.read<UniversitiesBloc>().add(LoadUniversities());
                  });
                },
              );
            }).toList(),
          )
        : const SizedBox.shrink();
  }
}
