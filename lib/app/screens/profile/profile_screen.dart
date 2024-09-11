import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_settings/profile_settings_page.dart';
import 'package:wg_app/app/screens/profile/pages/profile_career/profile_career_screen.dart';
import 'package:wg_app/app/screens/profile/pages/profile_university/profile_university_screen.dart';
import 'package:wg_app/app/screens/profile/widgets/profile_container.dart';
import 'package:wg_app/app/screens/profile_growth/profile_growth_screen.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          LocaleKeys.profile.tr(),
          style: AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              final RenderBox button = context.findRenderObject() as RenderBox;
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

              showMenu<int>(
                context: context,
                color: AppColors.whiteForText,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width, // left
                  position.dy + 110, // top (under the button)
                  10, // right
                  0, // bottom (not used)
                ),
                items: [
                  PopupMenuItem<int>(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Настройки профиля'),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text('Язык'),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Выйти', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ).then((value) async {
                if (value != null) {
                  if (value == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
                    );
                  }
                  if (value == 2) {
                    await LocalUtils.logout();
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => WeGlobalApp()), (route) => true);
                  }
                  if (value == 3) {
                    await LocalUtils.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => WeGlobalApp()),
                        (route) => true);
                  }
                }
              });
            },
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdatedSuccess) {
            CustomSnackbar().showCustomSnackbar(context, 'Updated successfully!', true);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/profile-dummy.png'),
                      const SizedBox(height: 16),
                      Text(
                        'Адилет Дегитаев',
                        style: AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
                      ),
                      const SizedBox(height: 36),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Бирнарсе',
                          style: AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
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
                                  print('Career');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileCareerScreen(),
                                    ),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileUniversityScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ProfileContainer(
                        text: 'Личный \nрост'.tr(),
                        isUniversity: false,
                        height: 144,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileGrowthScreen()),
                          );
                        },
                      ),
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
      ),
    );
  }
}
