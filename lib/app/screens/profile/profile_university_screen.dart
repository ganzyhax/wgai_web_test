import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileStorageContainer(
              title: 'Мои ВУЗ-ы',
              buttonTitle: 'Browse universities',
              description: 'Здесь будут хранится ваши избранные ВУЗ-ы.',
              onButtonTap: () {
                print('tapped my uni 1');
              },
            ),
            SizedBox(height: 16),
            ProfileStorageContainer(
              title: 'ЕНТ',
              showLeftIcon: true,
              showContainer: true,
              buttonTitle: 'Browse universities',
              description:
                  'Здесь будут хранится ваши  ВУЗ-ы для поступления по ЕНТ.',
              onButtonTap: () {
                print('tapped my uni 2');
              },
            ),
          ],
        ),
      ),
    );
  }
}