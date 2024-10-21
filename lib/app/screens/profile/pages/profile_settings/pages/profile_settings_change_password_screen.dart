import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ProfileSettingsChangePasswordScreen extends StatelessWidget {
  const ProfileSettingsChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController newPasswordRepeat = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          LocaleKeys.settings.tr(),
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hintText: LocaleKeys.current_password.tr(),
                  controller: currentPassword),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hintText: LocaleKeys.new_password.tr(),
                  controller: newPassword),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hintText: LocaleKeys.repeat_new_password.tr(),
                  controller: newPasswordRepeat),
              SizedBox(
                height: 15,
              ),
              CustomButton(text: LocaleKeys.change_password.tr(), onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
