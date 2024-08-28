import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/register/bloc/register_bloc.dart';
import 'package:wg_app/app/screens/register/register_verify_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rPass = TextEditingController();
  String errorString = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(_onTextChangedEmail);
    pass.addListener(_onTextChangedPass);
    rPass.addListener(_onTextChangedRPass);
  }

  bool passShow = true;
  bool rpassShow = true;
  String? emailValidator;
  String? passwordValidator;
  String? passwordMatchValidator;
  void _onTextChangedEmail() {
    setState(() {});
    bool res = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.text.toString());
    if (res == true) {
      setState(() {
        emailValidator = '';
      });
    } else {
      setState(() {
        emailValidator = 'Введите корректный email-адрес';
      });
    }
  }

  void _onTextChangedPass() {
    setState(() {});
    if (pass.text.length < 8) {
      passwordValidator =
          'Пароль должен содержать минимум 8 символов, включая как минимум одну цифру';
    } else {
      if (rPass.text.length > 8) {
        if (rPass.text != pass.text) {
          passwordMatchValidator = 'Введенные пароли не совпадают';
        } else {
          passwordMatchValidator = '';
        }
      }
      passwordValidator = '';
    }
    setState(() {});
  }

  void _onTextChangedRPass() {
    setState(() {});
    if (pass.text != rPass.text) {
      passwordMatchValidator = 'Введенные пароли не совпадают';
    } else {
      passwordMatchValidator = '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterError) {
              CustomSnackbar()
                  .showCustomSnackbar(context, state.message, false);
            }
            if (state is RegisterReturnVerifyPage) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterVerifyPage()),
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is RegisterLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    Text(
                      'Регистрация',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Добро пожаловать!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  hintText: 'Электронная почта',
                                  controller: email),
                              (emailValidator == '' || emailValidator == null)
                                  ? const SizedBox()
                                  : Text(
                                      emailValidator.toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Пароль',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                hintText: '*******',
                                controller: pass,
                                passwordShow: passShow,
                                isPassword: true,
                                onTapIcon: () {
                                  if (passShow) {
                                    passShow = false;
                                  } else {
                                    passShow = true;
                                  }
                                  setState(() {});
                                },
                              ),
                              (passwordValidator == '' ||
                                      passwordValidator == null)
                                  ? const SizedBox()
                                  : Text(
                                      passwordValidator.toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Повторите пароль',
                                style: TextStyle(color: AppColors.grayForText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  hintText: '*******',
                                  passwordShow: rpassShow,
                                  onTapIcon: () {
                                    if (rpassShow) {
                                      rpassShow = false;
                                    } else {
                                      rpassShow = true;
                                    }
                                    setState(() {});
                                  },
                                  controller: rPass,
                                  isPassword: true),
                              (passwordMatchValidator == '' ||
                                      passwordMatchValidator == null)
                                  ? const SizedBox()
                                  : Text(
                                      passwordMatchValidator.toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
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
                                isLoading: state.isLoading,
                                text: 'Далее',
                                isDisabled: (email.text.isEmpty ||
                                    email.text.isEmpty ||
                                    emailValidator != '' ||
                                    passwordValidator != '' ||
                                    passwordMatchValidator != '' ||
                                    pass.text.isEmpty ||
                                    rPass.text.isEmpty),
                                onTap: () {
                                  if (pass.text == rPass.text) {
                                    BlocProvider.of<RegisterBloc>(context)
                                      ..add(RegisterRegister(
                                          email: email.text,
                                          password: pass.text,
                                          regCode: '12414'));
                                  } else {
                                    CustomSnackbar().showCustomSnackbar(
                                        context, 'Passwords not match', false);
                                  }
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
                                    'У меня есть аккаунт',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]))
                  ],
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
