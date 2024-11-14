import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/screens/forget_password/bloc/forget_password_bloc.dart';
import 'package:wg_app/app/screens/forget_password/pages/forget_password_verify_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  int resetType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoaded) {
            if (state.otpSended != '') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                          value: BlocProvider.of<ForgetPasswordBloc>(context),
                          child: ForgetPasswordVerifyPage(
                            regData:
                                (state.type == 0) ? email.text : phone.text,
                          ),
                        )),
              );
            }
          }
        },
        child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
          builder: (context, state) {
            if (state is ForgetPasswordLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                          child: Text(
                        LocaleKeys.forgotPassword.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w800),
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      (state.type == 0)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('E-mail'),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                    hintText: LocaleKeys.enter_email.tr(),
                                    controller: email),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.phone_number.tr()),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                    hintText: LocaleKeys.enter_number.tr(),
                                    controller: phone),
                              ],
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                BlocProvider.of<ForgetPasswordBloc>(context)
                                  ..add(ForgetPasswordChangeType());
                                email.text = '';
                                phone.text = '';
                              },
                              child: Text(
                                (state.type == 0)
                                    ? 'Reset by phone'
                                    : 'Reset by email',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                          text: 'Send OTP',
                          onTap: () {
                            if (state.type == 0) {
                              BlocProvider.of<ForgetPasswordBloc>(context)
                                ..add(ForgetPasswordSendEmailOTP(
                                    email: email.text));
                            } else {
                              BlocProvider.of<ForgetPasswordBloc>(context)
                                ..add(ForgetPasswordSendPhoneOTP(
                                    phone: phone.text));
                            }
                          })
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
