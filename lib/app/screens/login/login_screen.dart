import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/login/bloc/login_bloc.dart';
import 'package:wg_app/app/screens/navigator/main_navigator.dart';
import 'package:wg_app/app/screens/register/register_school_code_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool passwordShow = true;
TextEditingController login = TextEditingController();
TextEditingController password = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            CustomSnackbar().showCustomSnackbar(context, 'Error!', false);
          }
          if (state is LoginSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomNavigationBar()),
              (Route<dynamic> route) => false,
            );
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
                      'Вход',
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
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Логин',
                            style: TextStyle(color: AppColors.grayForText),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              hintText: 'Телефон или Email', controller: login),
                          SizedBox(
                            height: 15,
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
                            text: 'Войти',
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
                          Center(
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterSchoolCodePage()),
                              );
                            },
                            child: Center(
                              child: Text(
                                'Регистрация',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
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
