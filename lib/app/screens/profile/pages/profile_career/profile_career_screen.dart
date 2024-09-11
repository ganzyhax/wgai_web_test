import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/atlas/atlas_screen.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/widgets/career_card.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_storage_container.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ProfileCareerScreen extends StatelessWidget {
  const ProfileCareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = BookmarkData().getItems(AppHiveConstants.professions);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            (data.length == 0)
                ? ProfileStorageContainer(
                    title: LocaleKeys.my_professions.tr(),
                    buttonTitle: 'Browse careers'.tr(),
                    isMyCareer: true,
                    showLeftIcon: true,
                    showRightIcon: true,
                    description:
                        'Здесь будут хранится ваши избранные профессии.'.tr(),
                    onButtonTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AtlasScreen()),
                      );
                    },
                  )
                : CareerStorageContainer(
                    title: LocaleKeys.my_professions.tr(),
                  ),
            SizedBox(
              height: 15,
            ),

            ProfileStorageContainer(
              title: 'Рек. профессии'.tr(),
              buttonTitle: 'Browse careers'.tr(),
              isMyCareer: true,
              showLeftIcon: true,
              showRightIcon: true,
              description:
                  'Здесь будут хранится ваши избранные профессии.'.tr(),
              onButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AtlasScreen()),
                );
              },
            )
            // ProfileStorageContainer(
            //   title: 'Мои профессии'.tr(),
            //   showLeftIcon: true,
            //   isMyCareer: true,
            //   showRightIcon: true,
            //   buttonTitle: 'Browse universities'.tr(),
            //   description:
            //       'Здесь будут хранится ваши избранные профессии.'.tr(),
            //   onButtonTap: () {
            //     print('tapped my prof 2');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
