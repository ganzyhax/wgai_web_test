import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileUniversityScreen extends StatelessWidget {
  const ProfileUniversityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          LocaleKeys.my_universities_title.tr(), //Change
          style: AppTextStyle.titleHeading
              .copyWith(color: AppColors.calendarTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileStorageContainer(
              title: 'Мои ВУЗ-ы',
              buttonTitle: 'Browse universities',
              description: LocaleKeys.universities_storage.tr(),
              onButtonTap: () {
                print('tapped my uni 1');
              },
              isForeignUni: false,
            ),
            SizedBox(height: 16),
            ProfileStorageContainer(
              title: 'ЕНТ',
              showLeftIcon: true,
              buttonTitle: 'Browse universities',
              description:
                  'Здесь будут хранится ваши  ВУЗ-ы для поступления по ЕНТ.',
              onButtonTap: () {
                print('tapped my uni 2');
              },
              isForeignUni: false,
            ),
          ],
        ),
      ),
    );
  }
}
