import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/forget_password/bloc/forget_password_bloc.dart';
import 'package:wg_app/app/screens/forget_password/pages/forget_password_set_new_password_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForgetPasswordVerifyPage extends StatefulWidget {
  final String regData;
  const ForgetPasswordVerifyPage({super.key, required this.regData});

  @override
  State<ForgetPasswordVerifyPage> createState() =>
      _ForgetPasswordVerifyPageState();
}

class _ForgetPasswordVerifyPageState extends State<ForgetPasswordVerifyPage> {
  Timer? _timer;
  int _start = 60;
  bool _canResendCode = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 60;
      _canResendCode = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResendCode = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordOpenChangePasswordPage) {}
            // TODO: implement listener
          },
          child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
            builder: (context, state) {
              if (state is ForgetPasswordLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: (state.type == 0)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4.3,
                            ),
                            Center(
                                child: Image.asset(
                                    'assets/images/verify_email.png')),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Text(
                                'Подтвердите вашу почту',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            (_canResendCode)
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.send_again.tr(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _start.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                bgColor: (_canResendCode)
                                    ? AppColors.primary
                                    : Colors.grey[300],
                                textColor: (_canResendCode)
                                    ? Colors.white
                                    : Colors.black,
                                text: 'Send OTP again',
                                onTap: () {
                                  startTimer();
                                  BlocProvider.of<ForgetPasswordBloc>(context)
                                    ..add(ForgetPasswordSendEmailOTP(
                                        email: widget.regData));
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ForgetPasswordBloc>(context)
                                  ..add(ForgetPasswordChangeRegData());
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Change email',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4.3,
                            ),
                            Center(
                                child: Image.asset(
                                    'assets/images/verify_email.png')),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Text(
                                'Enter 4-digit verification code sent to phone ' +
                                    widget.regData,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 10),
                            OtpTextField(
                                numberOfFields: 4,
                                showCursor: false,
                                margin: EdgeInsets.only(right: 20),
                                borderColor: AppColors.primary,
                                showFieldAsBox: true,
                                onCodeChanged: (String code) {},
                                onSubmit: (String verificationCode) {
                                  if (state.otpSended == verificationCode) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgetPasswordSetNewPasswordPage()),
                                    );
                                  }
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            (_canResendCode)
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.send_again.tr(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _start.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                bgColor: (_canResendCode)
                                    ? AppColors.primary
                                    : Colors.grey[300],
                                textColor: (_canResendCode)
                                    ? Colors.white
                                    : Colors.black,
                                text: 'Send OTP again',
                                onTap: () {
                                  startTimer();
                                  BlocProvider.of<ForgetPasswordBloc>(context)
                                    ..add(ForgetPasswordSendPhoneOTP(
                                        phone: widget.regData));
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ForgetPasswordBloc>(context)
                                  ..add(ForgetPasswordChangeRegData());
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Change phone',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            )
                          ],
                        ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
