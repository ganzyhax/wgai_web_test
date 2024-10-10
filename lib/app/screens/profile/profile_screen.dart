import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/ai/ai_screen.dart';
import 'package:wg_app/app/screens/profile/bloc/profile_bloc.dart';
import 'package:wg_app/app/screens/profile/pages/profile_language/profile_language_screen.dart';
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
import 'package:wg_app/app/screens/login/login_screen.dart';

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
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
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
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;
              final Offset position =
                  button.localToGlobal(Offset.zero, ancestor: overlay);

              showMenu<int>(
                context: context,
                color: AppColors.whiteForText,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width,
                  position.dy + 110,
                  10,
                  0,
                ),
                items: [
                  PopupMenuItem<int>(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(LocaleKeys.profile_settings.tr()),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text(LocaleKeys.language.tr()),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(LocaleKeys.log_out.tr(),
                          style: TextStyle(color: Colors.red)),
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
                      MaterialPageRoute(
                          builder: (context) => ProfileSettingsPage()),
                    );
                  }
                  if (value == 2) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProfileLanguageScreen()),
                    );
                  }
                  if (value == 3) {
                    await LocalUtils.logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                }
              });
            },
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if (state is ProfileUpdatedSuccess) {
            CustomSnackbar()
                .showCustomSnackbar(context, 'Updated successfully!', true);
          } else if (state is AccountDeletedState) {
            CustomSnackbar().showCustomSnackbar(
                context, 'Аккаунт жойылды / Аккаунт удален', true);
            // So the user can see the message that they have actually deleted the account
            await Future.delayed(Duration(seconds: 3));
            await LocalUtils.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
            );
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
                      Container(
                        width: 64,
                        height: 64,
                        child: Image.asset(
                          'assets/images/avatar_image.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return Container(
                              width: 64,
                              height: 64,
                              color: Colors.grey,
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.fullName,
                        style: AppTextStyle.titleHeading
                            .copyWith(color: AppColors.blackForText),
                      ),
                      const SizedBox(height: 36),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocaleKeys.modules.tr(),
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
                                text: LocaleKeys.your_career
                                        .tr()
                                        .split(' ')[0] +
                                    '\n' +
                                    LocaleKeys.your_career.tr().split(' ')[1],
                                isUniversity: false,
                                height: 144,
                                onTap: () {
                                  print(
                                    LocaleKeys.your_career.tr(),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileCareerScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ProfileContainer(
                                text: LocaleKeys.your_university
                                        .tr()
                                        .split(' ')[0] +
                                    '\n' +
                                    LocaleKeys.your_university
                                        .tr()
                                        .split(' ')[1],
                                isUniversity: true,
                                height: 144,
                                onTap: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                    ..add(ProfileUniversitiesLoad());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileUniversityScreen(),
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
                        text: LocaleKeys.personal_growth.tr().split(' ')[0] +
                            '\n' +
                            LocaleKeys.personal_growth.tr().split(' ')[1],
                        isUniversity: false,
                        height: 144,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileGrowthScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      ProfileContainer(
                        text: LocaleKeys.advice.tr().split(' ')[0],
                        isUniversity: false,
                        height: 144,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AiScreen()),
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
