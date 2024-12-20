import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/atlas/atlas_complete_screen.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';

import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/bloc/profile_career_bloc.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class CareerStorageContainer extends StatefulWidget {
  final String title;
  final bool doNavigate;
  final bool isRecommendation;
  // ignore: prefer_typing_uninitialized_variables
  final professions;
  final isForeign;

  const CareerStorageContainer(
      {super.key,
      required this.title,
      required this.doNavigate,
      required this.isRecommendation,
      required this.professions,
      required this.isForeign});

  @override
  State<CareerStorageContainer> createState() => _CareerStorageContainerState();
}

class _CareerStorageContainerState extends State<CareerStorageContainer> {
  @override
  Widget build(BuildContext context) {
    var data = BookmarkData().getItems(AppHiveConstants.professions);

    return (!widget.isRecommendation)
        ? (data != null && data.length > 0)
            ? Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (widget.doNavigate) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtlasScreen()),
                          );
                          setState(() {});
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/chalkboard_teacher.svg'),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: AppTextStyle.heading3
                                  .copyWith(color: AppColors.calendarTextColor),
                            ),
                          ),
                          if (widget.doNavigate)
                            SvgPicture.asset(
                              'assets/icons/caret-right.svg',
                              width: 20,
                              height: 20,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (data.length > 5) ? 5 : data.length,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          final IconData? resolvedIcon =
                              myIconMap[data[index]['data']['areaIconCode']];
                          return GestureDetector(
                            onTap: () async {
                              var res = await ApiClient.get('api/occupations/' +
                                  data[index]['id'].toString());

                              if (res['success']) {
                                final profession = res['data']['occupation'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AtlasCompleteScreen(
                                      profession: profession,
                                      professionsId: data[index]['id'],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (resolvedIcon != null)
                                      ? PhosphorIcon(
                                          resolvedIcon,
                                          color: AppColors.primary,
                                          size: 24,
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        data[index]['data']['name']
                                            [context.locale.languageCode],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  GestureDetector(
                                      onTap: () async {
                                        BlocProvider.of<ProfileCareerBloc>(
                                            context)
                                          ..add(ProfileDeleteCareer(
                                              occupationCode: data[index]
                                                  ['id']));
                                        setState(() {});
                                      },
                                      child: Icon(Icons.bookmark))
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(height: 15),
                  ],
                ),
              )
            : ProfileStorageContainer(
                title: LocaleKeys.my_professions.tr(),
                buttonTitle: LocaleKeys.professions_overview.tr(),
                isMyCareer: true,
                showLeftIcon: true,
                showRightIcon: true,
                description: LocaleKeys.my_professions_storage.tr(),
                onButtonTap: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AtlasScreen()),
                  );
                  setState(() {});
                },
                isForeignUni: true,
              )
        : (widget.professions != null && widget.professions.length > 0)
            ? Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (widget.doNavigate) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtlasScreen()),
                          );
                          setState(() {});
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/chalkboard_teacher.svg'),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: AppTextStyle.heading3
                                  .copyWith(color: AppColors.calendarTextColor),
                            ),
                          ),
                          if (widget.doNavigate)
                            SvgPicture.asset(
                              'assets/icons/caret-right.svg',
                              width: 20,
                              height: 20,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.professions.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final IconData? resolvedIcon = myIconMap[
                            widget.professions[index]['areaIconCode']];
                        return Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              (resolvedIcon != null)
                                  ? PhosphorIcon(
                                      resolvedIcon,
                                      color: AppColors.primary,
                                      size: 24,
                                    )
                                  : SizedBox(width: 24),
                              SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Expanded(
                                child: Text(
                                  widget.professions[index]['name']
                                      [context.locale.languageCode],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      8), // Add some spacing between name and percentage
                              Text(
                                "${widget.professions[index]['matchPercentage']}%",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              )
            : ProfileStorageContainer(
                title: LocaleKeys.recommended_profession_name.tr(),
                buttonTitle: LocaleKeys.professions_overview.tr(),
                isMyCareer: true,
                showLeftIcon: true,
                showRightIcon: false,
                description: LocaleKeys.my_professions_storage.tr(),
                onButtonTap: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AtlasScreen()),
                  );
                  setState(() {});
                },
                isForeignUni: true,
              );
  }
}
