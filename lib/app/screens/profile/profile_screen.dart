import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_container.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          'Профиль',
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Settings button tapped');
            },
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/profile-dummy.png'),
              const SizedBox(height: 16),
              Text(
                'Адилет Дегитаев',
                style: AppTextStyle.titleHeading
                    .copyWith(color: AppColors.blackForText),
              ),
              const SizedBox(height: 36),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Бирнарсе',
                  style: AppTextStyle.titleHeading
                      .copyWith(color: AppColors.blackForText),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ProfileContainer(
                        text: 'Your \ncareer',
                        isUniversity: false,
                        height: 144,
                        onTap: () {
                          print('ncareer');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ProfileContainer(
                        text: 'Your University',
                        isUniversity: true,
                        height: 144,
                        onTap: () {
                          print('University');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ProfileContainer(
                text: 'Личный \nрост',
                isUniversity: false,
                height: 144,
                onTap: () {
                  print('Рост');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
