import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/profile/pages/profile_settings/pages/profile_change_email_and_pass/bloc/change_email_and_pass_bloc.dart';
import 'package:wg_app/app/utils/local_utils.dart';
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
            onPressed: () async {
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //       builder: (context) => CustomNavigationBar()),
              //   (Route<dynamic> route) => false,
              // );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ChangeEmailAndPassBloc, ChangeEmailAndPassState>(
          builder: (context, state) {
            if (state is ChangeEmailAndPassLoaded) {
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (state.emailNeeds == true)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Set phone number'),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: CustomTextField(
                                          hintText: '77471231122',
                                          controller: phone),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: CustomButton(
                                        text: 'Send otp',
                                        onTap: () async {
                                          if (phone.text.length == 11) {
                                            BlocProvider.of<
                                                ChangeEmailAndPassBloc>(context)
                                              ..add(ChangeEmailAndPassSendOTP(
                                                  phone: phone.text));
                                          } else {}
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                (state.otp != '')
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: CustomTextField(
                                                hintText: 'OTP',
                                                controller: otp),
                                          ),
                                          SizedBox(
                                            width: 110,
                                            child: CustomButton(
                                              text: 'Check',
                                              onTap: () {
                                                if (state.otp == otp.text) {
                                                  BlocProvider.of<
                                                          ChangeEmailAndPassBloc>(
                                                      context)
                                                    ..add(
                                                        ChangeEmailAndPassChangePhone(
                                                            phone: phone.text));
                                                  CustomSnackbar()
                                                      .showCustomSnackbar(
                                                          context,
                                                          'Email changed to phone!',
                                                          true);
                                                } else {
                                                  CustomSnackbar()
                                                      .showCustomSnackbar(
                                                          context,
                                                          'OTP not correct!',
                                                          false);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 15,
                      ),
                      (state.phoneNeeds == true)
                          ? Column(
                              children: [
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
                                    hintText:
                                        LocaleKeys.repeat_new_password.tr(),
                                    controller: newPasswordRepeat),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                    text: LocaleKeys.change_password.tr(),
                                    onTap: () {
                                      BlocProvider.of<ChangeEmailAndPassBloc>(
                                          context)
                                        ..add(ChangeEmailAndPassChangePass(
                                            pass: newPassword.text));
                                    })
                              ],
                            )
                          : SizedBox()
                    ],
                  ));
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
