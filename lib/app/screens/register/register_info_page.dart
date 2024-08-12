import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/textfields/custom_textfield.dart';
import 'package:wg_app/constants/app_colors.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({super.key});

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            Center(
              child: Text(
                'Давайт знакомиться!',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 26),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ваше имя',
                        style: TextStyle(color: AppColors.grayForText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(hintText: 'Ваше имя', controller: name),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Фамилия',
                        style: TextStyle(color: AppColors.grayForText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hintText: 'Ваша фамилия', controller: surname),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Номер телефона',
                        style: TextStyle(color: AppColors.grayForText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hintText: 'Введите номер', controller: phone),
                      SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        text: 'Далее',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
