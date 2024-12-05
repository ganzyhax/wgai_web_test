import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/bloc/foreign_university_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/widget/filter_modal.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/widget/foreign_univer_card.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForeignUniversitiesScreen extends StatefulWidget {
  const ForeignUniversitiesScreen({super.key});

  @override
  _ForeignUniversitiesScreenState createState() =>
      _ForeignUniversitiesScreenState();
}

class _ForeignUniversitiesScreenState extends State<ForeignUniversitiesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Trigger pagination when reaching the bottom of the list
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = context.read<ForeignUniversityBloc>().state;
      if (state is ForeignUniversityLoaded) {
        final currentPage = state.currentPage;
        final totalPages = state.totalPages;

        if (currentPage < totalPages) {
          // Load next page, preserving current filter values
          context.read<ForeignUniversityBloc>().add(
                ForeignUniversityLoad(
                  feeStartRange: state.feeStartRange,
                  feeEndRange: state.feeEndRange,
                  countryCode: state.currentCountryCode,
                  page: currentPage + 1, // Load next page
                  limit: 20,
                ),
              );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppbar(title: '', withBackButton: true),
      ),
      body: BlocBuilder<ForeignUniversityBloc, ForeignUniversityState>(
        builder: (context, state) {
          if (state is ForeignUniversityLoaded) {
            return SingleChildScrollView(
              controller: _scrollController, // Attach scroll controller
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: Column(
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
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return FilterBottomSheet(
                                  onApplyFilters: (filters) {
                                    // Apply new filters and reset pagination
                                    context.read<ForeignUniversityBloc>().add(
                                          ForeignUniversityLoad(
                                            feeStartRange: filters['feeValues']
                                                [0],
                                            feeEndRange: filters['feeValues']
                                                [1],
                                            countryCode: filters['countryCode'],
                                            page: 1,
                                            limit: 20,
                                          ),
                                        );
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
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data.length, // Use the global data list
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ForeignUniverCard(
                            data: state.data[index], // Display each university
                          ),
                        );
                      },
                    ),
                    if (state.currentPage < state.totalPages)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CircularProgressIndicator(),
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
}
