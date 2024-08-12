import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/register/register_verify_success_page.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class RegisterVerifyPage extends StatelessWidget {
  const RegisterVerifyPage({super.key});

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
            Image.asset('assets/images/verify_email.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Подтвердите вашу почту',
              style: AppTextStyle.heading1,
            ),
            Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Повторная отправка через:'),
                          Text('01:04'),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterVerifySuccessPage()),
                          );
                        },
                        isDisabled: true,
                        text: 'Далее',
                        textColor: Colors.black,
                        bgColor: AppColors.grayForText,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'Изменить почту',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
