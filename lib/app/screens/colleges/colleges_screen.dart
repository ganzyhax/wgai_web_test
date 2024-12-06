import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/colleges/bloc/colleges_bloc.dart';
import 'package:wg_app/app/screens/colleges/colleges_complete_screen.dart';
import 'package:wg_app/app/screens/colleges/widgets/college_filter_bottom.dart';
import 'package:wg_app/app/screens/colleges/widgets/college_info_card.dart';
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

class CollegesScreen extends StatefulWidget {
  CollegesScreen({super.key});

  @override
  State<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  List<dynamic> activeFilters = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    context.read<CollegesBloc>().add(CollegesLoad());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        context.read<CollegesBloc>().state is CollegesLoaded) {
      final state = context.read<CollegesBloc>().state as CollegesLoaded;
      if (state.currentPage < state.maxPage) {
        context.read<CollegesBloc>().add(CollegesNextPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
            title: '',
            withBackButton: true,
            onBackClicked: () {
              BlocProvider.of<CollegesBloc>(context)
                ..add(CollegesResetFilter());
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.colleges.tr(),
                    style: AppTextStyle.titleHeading
                        .copyWith(color: AppColors.blackForText),
                  ),
                  IconButton(
                    onPressed: () async {
                      var data = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              final universityCode = '';
                              return CollegeFilterBottomSheet(
                                onFilterApplied: (filters) {
                                  setState(() {
                                    activeFilters = filters;
                                  });
                                },
                                collegeCode: universityCode,
                              );
                            },
                          );
                        },
                      );
                      if (data == 'reset') {
                        activeFilters.clear();
                      }
                      setState(() {});
                    },
                    icon: SvgPicture.asset('assets/icons/filter.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildActiveFilters(),
              const SizedBox(height: 12),
              BlocBuilder<CollegesBloc, CollegesState>(
                builder: (context, state) {
                  if (state is CollegesLoaded) {
                    return ListView.builder(
                      itemCount: state.colleges.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final college = state.colleges[index];
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: UniContainers(
                              codeNumber: college['code'] ?? '',
                              title: college['name']
                                      [context.locale.languageCode] ??
                                  '',
                              firstDescription: college['regionName']
                                      [context.locale.languageCode] ??
                                  '',
                              secondDescription:
                                  college['specialties']?.length ?? 0,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CollegesCompleteScreen(
                                      college: college,
                                    ),
                                  ),
                                );
                              },
                            ));
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
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
                        context.read<CollegesBloc>().add(CollegesResetFilter());
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
                      context.read<CollegesBloc>().add(CollegesResetFilter());
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
