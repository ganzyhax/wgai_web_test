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
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
              title: LocaleKeys.my_career_title.tr(),
              withBackButton: true)),
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
                          doNavigate: true,
                          isRecommendation: false,
                          professions: state.myCareers,
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  CareerStorageContainer(
                    title: LocaleKeys.recommended_profession_name.tr(),
                    doNavigate: false,
                    isRecommendation: true,
                    professions: state.recCareers,
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
