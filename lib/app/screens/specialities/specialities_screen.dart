import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/specialities/specialities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class SpecialitiesScreen extends StatelessWidget {
  final String? specialityName;

  SpecialitiesScreen({super.key, this.specialityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
            title: LocaleKeys.specialities.tr(),
            withBackButton: true,
          )),
      body:
          //BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
          //   builder: (context, state) {
          //     if (state is SpecialitiesLoaded) {

          //     }
          //   },
          // ),
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.specialities.tr(),
                  style: AppTextStyle.heading2
                      .copyWith(color: AppColors.blackForText),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.filterGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.all_subjects.tr(),
                        style: AppTextStyle.heading4
                            .copyWith(color: AppColors.calendarTextColor),
                      ),
                      SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/expand_down.svg')
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
                builder: (context, state) {
                  if (state is SpecialitiesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SpecialitiesLoaded) {
                    return ListView.builder(
                      itemCount: state.specialResources?.length,
                      itemBuilder: (context, index) {
                        final specialResources = state.specialResources?[index];
                        if (specialityName == null) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: UniContainers(
                              codeNumber: specialResources?.code ?? '',
                              title: specialResources?.name
                                      ?.getLocalizedString(context) ??
                                  '',
                              firstDescription: specialResources
                                      ?.profileSubjects?[0].name
                                      ?.getLocalizedString(context) ??
                                  '',
                              secondDescription: specialResources
                                      ?.grants?.general?.grantsTotal ??
                                  0,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SpecialitiesCompleteScreen(
                                              data: specialResources!,
                                              speciesId:
                                                  specialResources?.code ?? '',
                                            )));
                              },
                            ),
                          );
                        } else {
                          return (specialResources != null &&
                                  specialResources.profileSubjects != null &&
                                  specialResources
                                      .profileSubjects!.isNotEmpty &&
                                  specialityName ==
                                      specialResources.profileSubjects![0].name
                                          ?.getLocalizedString(context))
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: UniContainers(
                                    codeNumber: specialResources.code ?? '',
                                    title: specialResources.name
                                            ?.getLocalizedString(context) ??
                                        '',
                                    firstDescription: specialResources
                                            .profileSubjects![0].name
                                            ?.getLocalizedString(context) ??
                                        '',
                                    secondDescription: specialResources
                                            .grants?.general?.grantsTotal ??
                                        0,
                                    onTap: () {
                                      BlocProvider.of<ProfileBloc>(context)
                                        ..add(ProfileSetUniSpecCode(
                                            value: specialResources.code!));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialitiesCompleteScreen(
                                                  data: specialResources,
                                                  isChooseUniversity: true,
                                                  speciesId:
                                                      specialResources.code ??
                                                          '',
                                                )),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox();
                        }
                      },
                    );
                  } else if (state is SpecialitiesError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
