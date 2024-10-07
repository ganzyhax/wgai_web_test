import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/bloc/programs_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/pages/programs_detail_screen.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/widgets/programs_card.dart';
import 'package:wg_app/app/screens/foreign/pages/programs/widgets/programs_filter_modal.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/bloc/foreign_university_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/widget/filter_modal.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/widget/foreign_univer_card.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/app/widgets/containers/item_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForeignProgramsScreen extends StatefulWidget {
  const ForeignProgramsScreen({super.key});

  @override
  _ForeignProgramsScreenState createState() => _ForeignProgramsScreenState();
}

class _ForeignProgramsScreenState extends State<ForeignProgramsScreen> {
  var activeFilters = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppbar(title: '', withBackButton: true),
      ),
      body: BlocBuilder<ProgramsBloc, ProgramsState>(
        builder: (context, state) {
          if (state is ProgramsLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.programs.tr(),
                          style: AppTextStyle.titleHeading
                              .copyWith(color: AppColors.blackForText),
                        ),
                        IconButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return ProgramsFilterModal(
                                  onApplyFilters: (filters) {
                                    activeFilters = [
                                      AppConstant.countriesCode[
                                              filters['countryCode']]![
                                          context.locale.languageCode]
                                    ];
                                    setState(() {});
                                    BlocProvider.of<ProgramsBloc>(context)
                                      ..add(ProgramsFilter(
                                          countryFilter:
                                              filters['countryCode']));
                                  },
                                );
                              },
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/filter.svg',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildActiveFilters(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForeignProgramsDetail(
                                  data: state.data[index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ProgramsCard(
                              name: state.data[index]['name']
                                      [context.locale.languageCode]
                                  .toString(),
                              countryCode: AppConstant.countriesCode[
                                      state.data[index]['countryCode']]![
                                      context.locale.languageCode]
                                  .toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
                if (filter.containsKey('countryCode')) {
                  return ItemContainer(
                    text: filter['regionName'], // Display the region name
                    icon: 'assets/icons/x.svg',
                    color: AppColors.onTheBlue2,
                    onTap: () {
                      setState(() {
                        activeFilters = [];
                        context.read<ProgramsBloc>().add(ProgramsResetFilter());
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
                    activeFilters = [];
                    setState(() {});
                    context.read<ProgramsBloc>().add(ProgramsResetFilter());
                  },
                );
              }
              return SizedBox.shrink();
            }).toList(),
          )
        : const SizedBox.shrink();
  }
}
