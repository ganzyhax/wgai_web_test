import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/register/register_verify_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
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
                          hintText: 'Электронная почта', controller: email),
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
                      CustomTextField(hintText: '*******', controller: pass),
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
                      CustomTextField(hintText: '*******', controller: rPass),
                      SizedBox(
                        height: 10,
                      ),
                      (errorString == '')
                          ? SizedBox()
                          : Text(
                              errorString,
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: 'Далее',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterVerifyPage()),
                          );
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
        ),
      ),
    );
  }
}
