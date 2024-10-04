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

class ForeignUniversitiesScreen extends StatelessWidget {
  const ForeignUniversitiesScreen({super.key});

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
                                    context.read<ForeignUniversityBloc>().add(
                                          ForeignUniversityLoad(
                                            feeStartRange: null,
                                            feeEndRange: null,
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
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data['data'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ForeignUniverCard(
                              data: state.data['data'][index]),
                        );
                      },
                    ),
                    // Add pagination controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle previous page logic
                            if (state.currentPage > 1) {
                              context.read<ForeignUniversityBloc>().add(
                                    ForeignUniversityLoad(
                                      feeStartRange: null,
                                      feeEndRange: null,
                                      countryCode: state.currentCountryCode,
                                      page: state.currentPage! -
                                          1, // Use `!` to assert it is non-null
                                      limit: 20, // Default limit
                                    ),
                                  );
                            }
                          },
                          child: Text('Предедущий'),
                        ),
                        Text(state.data['currentPage'].toString() +
                            '/' +
                            state.data['totalPages'].toString()),
                        ElevatedButton(
                          onPressed: () {
                            // Handle next page logic
                            context.read<ForeignUniversityBloc>().add(
                                  ForeignUniversityLoad(
                                    feeStartRange: null,
                                    feeEndRange: null,
                                    countryCode: state.currentCountryCode,
                                    page: (state.currentPage ?? 0) +
                                        1, // Ensure it's not null
                                    limit: 20, // Default limit
                                  ),
                                );
                          },
                          child: Text('Далее'),
                        ),
                      ],
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
