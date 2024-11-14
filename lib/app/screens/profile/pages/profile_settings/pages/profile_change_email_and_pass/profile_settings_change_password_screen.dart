import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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

  bool showPass1 = true;
  bool showPass2 = true;
  bool showPass3 = true;

  Timer? _timer;
  int _start = 60;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _start = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

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
          LocaleKeys.change_email.tr(),
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ChangeEmailAndPassBloc, ChangeEmailAndPassState>(
          builder: (context, state) {
            if (state is ChangeEmailAndPassLoaded) {
              return BlocListener<ChangeEmailAndPassBloc,
                  ChangeEmailAndPassState>(
                listener: (context, state) {
                  if (state is ChangeEmailAndPassPhoneSuccess) {
                    CustomSnackbar().showCustomSnackbar(
                        context, 'Phone set successfully!', true);
                  }
                  if (state is ChangeEmailAndPassPassSuccess) {
                    CustomSnackbar()
                        .showCustomSnackbar(context, 'Password changed!', true);
                  }
                  if (state is ChangeEmailAndPassSuccess) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => CustomNavigationBar(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (state.emailNeeds == true)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (state.otp != '')
                                      ? SizedBox()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.enter_number.tr(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.6,
                                                  child: CustomTextField(
                                                      hintText:
                                                          '7(777)-777-77-77',
                                                      controller: phone),
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                  child: CustomButton(
                                                    text: 'Send otp',
                                                    onTap: () async {
                                                      if (phone.text.length ==
                                                          11) {
                                                        BlocProvider.of<
                                                                ChangeEmailAndPassBloc>(
                                                            context)
                                                          ..add(
                                                              ChangeEmailAndPassSendOTP(
                                                                  phone: phone
                                                                      .text));
                                                        startTimer();
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                  SizedBox(height: 15),
                                  (state.otp != '')
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Enter 4-digit verification code sent to phone ' +
                                                  phone.text,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 10),
                                            OtpTextField(
                                                numberOfFields: 4,
                                                showCursor: false,
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                borderColor: AppColors.primary,
                                                showFieldAsBox: true,
                                                onCodeChanged: (String code) {},
                                                onSubmit:
                                                    (String verificationCode) {
                                                  if (state.otp ==
                                                      verificationCode) {
                                                    BlocProvider.of<
                                                            ChangeEmailAndPassBloc>(
                                                        context)
                                                      ..add(ChangeEmailAndPassChangePhone(
                                                          otp: verificationCode,
                                                          phone: phone.text));
                                                  }
                                                }),
                                            SizedBox(height: 10),
                                            (_start > 0)
                                                ? Text(
                                                    'Resend code in $_start seconds',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.primary),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                              ChangeEmailAndPassBloc>(
                                                          context)
                                                        ..add(
                                                            ChangeEmailAndPassSendOTP(
                                                                phone: phone
                                                                    .text));
                                                      startTimer();
                                                    },
                                                    child: Text(
                                                      'Send code again',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primary),
                                                    ),
                                                  ),
                                            SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<
                                                        ChangeEmailAndPassBloc>(
                                                    context)
                                                  ..add(
                                                      ChangeEnailAndPassSetOtherPhone());
                                              },
                                              child: Text(
                                                'Change phone',
                                                style: TextStyle(
                                                    color: AppColors.primary),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              )
                            : Text(
                                'Phone added',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                        SizedBox(height: 15),
                        (state.phoneNeeds == true)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.change_password.tr(),
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 15),
                                  CustomTextField(
                                      onTapIcon: () {
                                        setState(() {
                                          showPass1 = !showPass1;
                                        });
                                      },
                                      isPassword: true,
                                      passwordShow: showPass1,
                                      hintText:
                                          LocaleKeys.current_password.tr(),
                                      controller: currentPassword),
                                  SizedBox(height: 15),
                                  CustomTextField(
                                      onTapIcon: () {
                                        setState(() {
                                          showPass2 = !showPass2;
                                        });
                                      },
                                      passwordShow: showPass2,
                                      isPassword: true,
                                      hintText: LocaleKeys.new_password.tr(),
                                      controller: newPassword),
                                  SizedBox(height: 15),
                                  CustomTextField(
                                      isPassword: true,
                                      onTapIcon: () {
                                        setState(() {
                                          showPass3 = !showPass3;
                                        });
                                      },
                                      passwordShow: showPass3,
                                      hintText:
                                          LocaleKeys.repeat_new_password.tr(),
                                      controller: newPasswordRepeat),
                                  SizedBox(height: 15),
                                  CustomButton(
                                      text: LocaleKeys.change_password.tr(),
                                      onTap: () {
                                        if (newPassword.text ==
                                            newPasswordRepeat.text) {
                                          BlocProvider.of<
                                              ChangeEmailAndPassBloc>(context)
                                            ..add(ChangeEmailAndPassChangePass(
                                                pass: newPassword.text));
                                        } else {
                                          CustomSnackbar().showCustomSnackbar(
                                              context,
                                              LocaleKeys.password_are_not_match
                                                  .tr(),
                                              false);
                                        }
                                      })
                                ],
                              )
                            : SizedBox(),
                      ],
                    )),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
