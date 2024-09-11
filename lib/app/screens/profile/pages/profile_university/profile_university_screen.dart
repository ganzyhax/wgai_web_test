import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_kz_storage_card.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/widgets/university_special_select_modal.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileUniversityScreen extends StatelessWidget {
  const ProfileUniversityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Мои ВУЗ-ы',
          style: AppTextStyle.titleHeading
              .copyWith(color: AppColors.calendarTextColor),
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
                      title: 'Мои ВУЗ-ы',
                      buttonTitle: 'Browse universities',
                      description: 'Здесь будут хранится ваши избранные ВУЗ-ы.',
                      onButtonTap: () {},
                    ),
                    SizedBox(height: 16),
                    (state.selectedSpeciality != '')
                        ? UniversityKzStorageContainer(
                            title: 'ЕНТ',
                            mySpeciality: state.selectedSpeciality,
                          )
                        : SizedBox(),
                    SizedBox(height: 16),
                    (state.selectedSpeciality == '')
                        ? ProfileStorageContainer(
                            title: 'ЕНТ',
                            showLeftIcon: true,
                            buttonTitle: 'Browse speciality',
                            description:
                                'Здесь будут хранится ваши  ВУЗ-ы для поступления по ЕНТ.',
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
