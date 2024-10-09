import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/foreign/pages/universities/foreign_universities_screen.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_foreign_storage_card.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_storage_card.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_special_select_modal.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileUniversityScreen extends StatelessWidget {
  const ProfileUniversityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppbar(
              title: LocaleKeys.my_universities_title.tr(),
              withBackButton: true)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    (state.selectedForeignUniversities.length == 0)
                        ? ProfileStorageContainer(
                            title: LocaleKeys.my_universities_title.tr(),
                            buttonTitle: LocaleKeys.university_overview.tr(),
                            description: LocaleKeys.universities_storage.tr(),
                            onButtonTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ForeignUniversitiesScreen(),
                                ),
                              );
                            },
                          )
                        : UniversityForeignStorageCard(
                            title: LocaleKeys.my_universities_title.tr(),
                          ),
                    SizedBox(height: 16),
                    (state.selectedSpeciality != null)
                        ? UniversityKzStorageContainer(
                            title: LocaleKeys.ent.tr(),
                            mySpeciality: state.selectedSpeciality[
                                context.locale.languageCode],
                          )
                        : SizedBox(),
                    SizedBox(height: 16),
                    (state.selectedSpeciality == '' ||
                            state.selectedSpeciality == null)
                        ? ProfileStorageContainer(
                            title: LocaleKeys.ent.tr(),
                            showLeftIcon: true,
                            buttonTitle: LocaleKeys.professions_overview.tr(),
                            description:
                                LocaleKeys.ent_universities_storage.tr(),
                            onButtonTap: () {
                              if (state.selectedSpeciality == '' ||
                                  state.selectedSpeciality == null) {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return BlocProvider.value(
                                        value: BlocProvider.of<ProfileBloc>(
                                            context),
                                        child: UniversitySpecialSelectModal());
                                  },
                                );
                              }
                            },
                          )
                        : SizedBox()
                  ],
                ),
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
