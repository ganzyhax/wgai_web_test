import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/screens/specialities/widgets/grants_container.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/screens/universities/universities_complete_screen.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_complete.dart';
import 'package:wg_app/app/screens/universities/widgets/uni_containers.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';

class SpecialitiesCompleteScreen extends StatefulWidget {
  final String speciesId;
  final bool? isChooseUniversity;
  const SpecialitiesCompleteScreen({
    super.key,
    this.isChooseUniversity,
    required this.speciesId,
  });

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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Специальность'.tr(),
            style: AppTextStyle.heading1.copyWith(
              color: AppColors.calendarTextColor,
            )),
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
      ),
      body: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
        builder: (context, state) {
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
                      code: state.specialResources?[0].code ?? '',
                      title: state.specialResources?[0].name
                              ?.getLocalizedString(context) ??
                          '',
                      description: state
                              .specialResources?[0].profileSubjects?[0].name
                              ?.getLocalizedString(context) ??
                          '',
                      isUnivesity: false,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Гранты',
                      style: AppTextStyle.titleHeading
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Общий конкурс',
                      style: AppTextStyle.bodyTextMiddle
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: 'Количество грантов',
                      isResults: false,
                      grantItems: state.specialResources?[0].grants?.general
                              ?.grantScores ??
                          [],
                      grantTotal: state.specialResources?[0].grants?.general
                              ?.grantsTotal ??
                          0,
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                        title: 'Результаты прошлых ЕНТ',
                        isResults: true,
                        grantItems: state.specialResources?[0].grants?.general
                                ?.grantScores ??
                            [],
                        grantTotal: state.specialResources?[0].grants?.general
                                ?.grantsTotal ??
                            0),
                    const SizedBox(height: 16),
                    Text(
                      'Сельская квота',
                      style: AppTextStyle.bodyTextMiddle
                          .copyWith(color: AppColors.calendarTextColor),
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: 'Результаты прошлых ЕНТ',
                      isResults: true,
                      grantItems: state.specialResources?[0].grants?.rural
                              ?.grantScores ??
                          [],
                      grantTotal: state.specialResources?[0].grants?.rural
                              ?.grantsTotal ??
                          0,
                    ),
                    const SizedBox(height: 16),
                    GrantsContainer(
                      title: 'Количество грантов',
                      isResults: false,
                      grantItems: state.specialResources?[0].grants?.rural
                              ?.grantScores ??
                          [],
                      grantTotal: state.specialResources?[0].grants?.rural
                              ?.grantsTotal ??
                          0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'universities'.tr(),
                      style: AppTextStyle.titleHeading
                          .copyWith(color: AppColors.calendarTextColor),
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
                            itemCount: state.universities?.length,
                            itemBuilder: (context, index) {
                              final university = state.universities?[index];
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
