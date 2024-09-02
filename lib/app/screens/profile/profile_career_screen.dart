import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileCareerScreen extends StatelessWidget {
  const ProfileCareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Моя карьера',
          style: AppTextStyle.titleHeading
              .copyWith(color: AppColors.calendarTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileStorageContainer(
              title: 'Мои профессии'.tr(),
              buttonTitle: 'Browse universities'.tr(),
              isMyCareer: true,
              showLeftIcon: true,
              showRightIcon: true,
              description:
                  'Здесь будут хранится ваши избранные профессии.'.tr(),
              onButtonTap: () {
                print('tapped my prof 1');
              },
            ),
            SizedBox(height: 16),
            ProfileStorageContainer(
              title: 'Мои профессии'.tr(),
              showLeftIcon: true,
              isMyCareer: true,
              showRightIcon: true,
              buttonTitle: 'Browse universities'.tr(),
              description:
                  'Здесь будут хранится ваши избранные профессии.'.tr(),
              onButtonTap: () {
                print('tapped my prof 2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
