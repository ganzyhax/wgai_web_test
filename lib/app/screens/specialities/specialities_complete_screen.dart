import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/app/screens/specialities/widgets/grants_container.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/universities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_complete.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class SpecialitiesCompleteScreen extends StatefulWidget {
  final String speciesId;
  final bool? isChooseUniversity;
  final Specialties data;
  const SpecialitiesCompleteScreen(
      {super.key,
      this.isChooseUniversity,
      required this.speciesId,
      required this.data});

  @override
  State<SpecialitiesCompleteScreen> createState() =>
      SpecialitiesCompleteScreenState();
}

class SpecialitiesCompleteScreenState
    extends State<SpecialitiesCompleteScreen> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = false;
    super.initState();
  }

  void toggleBookmark() async {
    if (isBookmarked) {
      await BookmarkData().removeItem('bookmarks', widget.speciesId);
    } else {
      await BookmarkData().addItem(
          'bookmarks', {'id': widget.speciesId, 'data': widget.speciesId});
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
            title: LocaleKeys.speciality.tr(),
            withBackButton: true,
            actions: [
              IconButton(
                onPressed: () {
                  toggleBookmark();
                  print('Id: ${widget.speciesId}');
                },
                icon: isBookmarked
                    ? SvgPicture.asset('assets/icons/bookmark.svg')
                    : SvgPicture.asset('assets/icons/bookmark-open.svg'),
              ),
            ],
          )),
      body: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
        builder: (context, state) {
          log(widget.data.toString());
          if (state is SpecialitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpecialitiesLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UniComplete(
                      code: widget.data.code ?? '',
                      title: widget.data.name!
                          .toJson()[context.locale.languageCode],
                      description:
                          widget.data.name!.getLocalizedString(context) ?? '',
                      isUnivesity: false,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.grants.tr(),
                      style: AppTextStyle.titleHeading
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.general_competition.tr(),
                      style: AppTextStyle.bodyTextMiddle
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: LocaleKeys.number_of_grants.tr(),
                      isResults: false,
                      grantItems:
                          widget.data.grants?.general?.grantScores ?? [],
                      grantTotal: widget.data.grants?.general?.grantsTotal ?? 0,
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                        title: LocaleKeys.result_of_past_unt.tr(),
                        isResults: true,
                        grantItems:
                            widget.data.grants?.general?.grantScores ?? [],
                        grantTotal:
                            widget.data.grants?.general?.grantsTotal ?? 0),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.rural_quota.tr(),
                      style: AppTextStyle.bodyTextMiddle
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: LocaleKeys.result_of_past_unt.tr(),
                      isResults: true,
                      grantItems: widget.data.grants?.rural?.grantScores ?? [],
                      grantTotal: widget.data.grants?.rural?.grantsTotal ?? 0,
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: LocaleKeys.number_of_grants.tr(),
                      isResults: false,
                      grantItems: widget.data.grants?.rural?.grantScores ?? [],
                      grantTotal: widget.data.grants?.rural?.grantsTotal ?? 0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'universities'.tr(),
                      style: AppTextStyle.titleHeading
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<UniversitiesBloc, UniversitiesState>(
                      builder: (context, state) {
                        if (state is UniversitiesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is UniversitiesLoaded) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.data.universities!.length,
                            itemBuilder: (context, index) {
                              final university =
                                  widget.data.universities?[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: UniContainers(
                                  codeNumber: university?.code ?? '',
                                  title: university?.name
                                          ?.getLocalizedString(context) ??
                                      '',

                                  // firstDescription: university?.regionName?.getLocalizedString(context) ?? '',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            (widget.isChooseUniversity != null)
                                                ? UniversitiesCompleteScreen(
                                                    universityId:
                                                        university?.code ?? '',
                                                    isChooseUniversity: true,
                                                  )
                                                : UniversitiesCompleteScreen(
                                                    universityId:
                                                        university?.code ?? '',
                                                  ),
                                      ),
                                    );
                                  },
                                  isComplete: true,
                                ),
                              );
                            },
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
          } else if (state is SpecialitiesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
