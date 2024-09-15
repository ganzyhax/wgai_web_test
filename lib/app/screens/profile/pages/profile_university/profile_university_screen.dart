import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_storage_card.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_special_select_modal.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  LocaleKeys.my_universities_title.tr(),
                  style: AppTextStyle.titleHeading.copyWith(
                    color: AppColors.blackForText,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                )
              ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileStorageContainer(
                      title: LocaleKeys.my_universities_title.tr(),
                      buttonTitle: LocaleKeys.university_overview.tr(),
                      description: LocaleKeys.universities_storage.tr(),
                      onButtonTap: () {},
                    ),
                    SizedBox(height: 16),
                    (state.selectedSpeciality != '')
                        ? UniversityKzStorageContainer(
                            title: LocaleKeys.ent.tr(),
                            mySpeciality: state.selectedSpeciality,
                          )
                        : SizedBox(),
                    SizedBox(height: 16),
                    (state.selectedSpeciality == '')
                        ? ProfileStorageContainer(
                            title: LocaleKeys.ent.tr(),
                            showLeftIcon: true,
                            buttonTitle: LocaleKeys.professions_overview.tr(),
                            description:
                                LocaleKeys.ent_universities_storage.tr(),
                            onButtonTap: () {
                              if (state.selectedSpeciality == '') {
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
