import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:http/http.dart' as http;

class ProfileSettingsChangePasswordScreen extends StatefulWidget {
  const ProfileSettingsChangePasswordScreen({super.key});

  @override
  State<ProfileSettingsChangePasswordScreen> createState() =>
      _ProfileSettingsChangePasswordScreenState();
}

class _ProfileSettingsChangePasswordScreenState
    extends State<ProfileSettingsChangePasswordScreen> {
  bool isOtpSended = false;
  String checkOtp = '';
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordRepeat = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Change email to phone'),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: CustomTextField(
                        hintText: '77471231122', controller: phone),
                  ),
                  SizedBox(
                    width: 110,
                    child: CustomButton(
                      text: 'Send otp',
                      onTap: () async {
                        setState(() {
                          isOtpSended = false;
                        });
                        if (phone.text.length == 11) {
                          final random = Random();

                          int randomNumber = 1000 + random.nextInt(9000);
                          var mobizonRes = await sendSmsCode(
                              phone.text, randomNumber.toString());
                          if (mobizonRes['success']) {
                            setState(() {
                              isOtpSended = true;
                              checkOtp = randomNumber.toString();
                            });
                          }
                        } else {}
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              (isOtpSended)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child:
                              CustomTextField(hintText: 'OTP', controller: otp),
                        ),
                        SizedBox(
                          width: 110,
                          child: CustomButton(
                            text: 'Check',
                            onTap: () {
                              if (checkOtp == otp.text) {
                                CustomSnackbar().showCustomSnackbar(
                                    context, 'Email changed to phone!', true);
                              } else {
                                CustomSnackbar().showCustomSnackbar(
                                    context, 'OTP not correct!', false);
                              }
                            },
                          ),
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 15,
              ),
              Text(LocaleKeys.change_password.tr()),
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

  sendSmsCode(phone, code) async {
    final url = Uri.parse(
        'https://api.mobizon.kz/service/message/sendsmsmessage?recipient=$phone&text=WeGlobal Ваш код - $code&apiKey=kzff7e39f70c4780fb84cf85e6ee93a92de9bbe56d2aa095bc2d12efca0c183315ff94');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Mobapp-Version': mbVer
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'data': jsonDecode(response.body)};
    }
  }
}
