import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/bloc/login_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/profile/pages/profile_settings/pages/profile_settings_change_password_screen.dart';
import 'package:wg_app/app/screens/register/register_school_code_screen.dart';
import 'package:wg_app/app/screens/register/register_screen.dart';
import 'package:wg_app/app/screens/splash/components/pages/splash_choose_language_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordShow = true;
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is LoginSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomNavigationBar()),
              (Route<dynamic> route) => false,
            );
            if (state.mustChangePassword) {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       title: Text(
              //         LocaleKeys.please_change_your_password.tr(),
              //         style:
              //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //       ),
              //       content: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Expanded(
              //             child: CustomButton(
              //               height: 45,
              //               bgColor: Colors.grey[400],
              //               text: LocaleKeys.cancel.tr(),
              //               onTap: () {
              //                 Navigator.of(context).pop();
              //               },
              //             ),
              //           ),
              //           const SizedBox(width: 16),
              //           Expanded(
              //             child: CustomButton(
              //               height: 45,
              //               text: LocaleKeys.change.tr(),
              //               onTap: () async {
              //                 Navigator.pop(context);
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           ProfileSettingsChangePasswordScreen()),
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileSettingsChangePasswordScreen()),
              );
            }
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Text(
                      LocaleKeys.enter.tr(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.welcome.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.login.tr(),
                            style: TextStyle(color: AppColors.grayForText),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              isEmail: true,
                              hintText: LocaleKeys.phoneOrEmail.tr(),
                              // hintText: '',
                              controller: login),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            LocaleKeys.password.tr(),
                            style: TextStyle(color: AppColors.grayForText),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hintText: '*******',
                            controller: password,
                            isPassword: true,
                            onTapIcon: () {
                              if (passwordShow) {
                                passwordShow = false;
                              } else {
                                passwordShow = true;
                              }
                              setState(() {});
                            },
                            passwordShow: passwordShow,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          CustomButton(
                            text: LocaleKeys.login.tr(),
                            isLoading: state.isLoading,
                            onTap: () {
                              BlocProvider.of<LoginBloc>(context)
                                ..add(LoginLog(
                                    login: login.text,
                                    password: password.text));
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //       builder: (context) =>
                          //     //           RegisterSchoolCodePage()),
                          //     // );
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => RegisterScreen()),
                          //     );
                          //   },
                          //   child: Center(
                          //     child: Text(
                          //       LocaleKeys.register.tr(),
                          //       style: TextStyle(
                          //           color: AppColors.primary,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //   ),
                          // ),
                        ],
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
    );
  }
}
