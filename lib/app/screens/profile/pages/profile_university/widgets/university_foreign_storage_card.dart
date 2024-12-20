import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/foreign_universities_screen.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class UniversityForeignStorageCard extends StatefulWidget {
  final String title;

  const UniversityForeignStorageCard({
    super.key,
    required this.title,
  });

  @override
  State<UniversityForeignStorageCard> createState() =>
      _UniversityForeignStorageCardState();
}

class _UniversityForeignStorageCardState
    extends State<UniversityForeignStorageCard> {
  @override
  Widget build(BuildContext context) {
    var data = BookmarkData().getItems(AppHiveConstants.globalUniversities);
    log(data.toString());
    return (data != null && data.length > 0)
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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForeignUniversitiesScreen()),
                    );
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/icons/chalkboard_teacher.svg'),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: AppTextStyle.heading3
                              .copyWith(color: AppColors.calendarTextColor),
                        ),
                      ),
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
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  data[index]['data']['name']
                                      [context.locale.languageCode],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  // BlocProvider.of<ProfileBloc>(context)
                                  //   ..add(ProfileDeleteMyCareerBookmark(
                                  //       occupationCode: data[index]['id']));
                                  await BookmarkData().removeItem(
                                      AppHiveConstants.globalUniversities,
                                      data[index]['id']);
                                  await ApiClient.post(
                                      'api/portfolio/myUniversity/foreign/removeBookmark',
                                      {'universityCode': data[index]['id']});

                                  setState(() {});
                                },
                                child: Icon(Icons.bookmark))
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 15),
                (data.length > 5)
                    ? CustomButton(
                        text: 'View All',
                        bgColor: AppColors.background,
                        textColor: Colors.black,
                        onTap: () {},
                      )
                    : SizedBox()
              ],
            ),
          )
        : ProfileStorageContainer(
            title: LocaleKeys.my_universities_title.tr(),
            buttonTitle: LocaleKeys.university_overview.tr(),
            isMyCareer: true,
            showLeftIcon: true,
            showRightIcon: true,
            description: LocaleKeys.universities_storage.tr(),
            onButtonTap: () async {
              final res = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForeignUniversitiesScreen()),
              );
              setState(() {});
            },
            isForeignUni: true,
          );
  }
}
