import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/bloc/profile_career_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/widgets/career_card.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ProfileCareerScreen extends StatefulWidget {
  const ProfileCareerScreen({super.key});

  @override
  State<ProfileCareerScreen> createState() => _ProfileCareerScreenState();
}

class _ProfileCareerScreenState extends State<ProfileCareerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          LocaleKeys.my_career_title.tr(),
          style: AppTextStyle.titleHeading
              .copyWith(color: AppColors.calendarTextColor),
        ),
      ),
      body: BlocBuilder<ProfileCareerBloc, ProfileCareerState>(
        builder: (context, state) {
          if (state is ProfileCareerLoaded) {
            var data = BookmarkData().getItems(AppHiveConstants.professions);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  (data.length == 0)
                      ? ProfileStorageContainer(
                          title: LocaleKeys.my_professions.tr(),
                          buttonTitle: LocaleKeys.professions_overview.tr(),
                          isMyCareer: true,
                          showLeftIcon: true,
                          showRightIcon: true,
                          description: LocaleKeys.my_professions_storage.tr(),
                          onButtonTap: () async {
                            final res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AtlasScreen()),
                            );
                            setState(() {});
                          },
                        )
                      : CareerStorageContainer(
                          title: LocaleKeys.my_professions.tr(),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileStorageContainer(
                    title: LocaleKeys.recommended_profession_name.tr(),
                    buttonTitle: LocaleKeys.view_all.tr(),
                    isMyCareer: true,
                    showLeftIcon: true,
                    showRightIcon: false,

                    description:
                        LocaleKeys.recommended_professions_storage.tr(),
                    // 'asdas',
                    onButtonTap: () async {
                      // final res = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AtlasScreen()),
                      // );
                      // setState(() {});
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
