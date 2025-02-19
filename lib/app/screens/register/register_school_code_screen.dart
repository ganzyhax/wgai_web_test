import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/register/register_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class RegisterSchoolCodePage extends StatefulWidget {
  const RegisterSchoolCodePage({super.key});

  @override
  State<RegisterSchoolCodePage> createState() => _RegisterSchoolCodePageState();
}

class _RegisterSchoolCodePageState extends State<RegisterSchoolCodePage> {
  TextEditingController code = TextEditingController();
  String errorString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterReturnRegisterPage) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            }
            if (state is RegisterError) {
              CustomSnackbar()
                  .showCustomSnackbar(context, state.message, false);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Text(
                  LocaleKeys.registration.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  LocaleKeys.enter_school_code.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Код',
                            style: TextStyle(color: AppColors.grayForText),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              hintText: LocaleKeys.schoolCode.tr(),
                              controller: code),
                          SizedBox(
                            height: 10,
                          ),
                          (errorString == '')
                              ? SizedBox()
                              : Text(
                                  errorString,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: LocaleKeys.next.tr(),
                            onTap: () {
                              BlocProvider.of<RegisterBloc>(context)
                                ..add(RegisterCheckClassCode(code: code.text));
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Center(
                              child: Text(
                                LocaleKeys.haveAnAccount.tr(),
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ]))
              ],
            ),
          ),
        ));
  }
}
