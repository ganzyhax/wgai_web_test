import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/register/register_info_page.dart';
import 'package:wg_app/constants/app_colors.dart';

class RegisterVerifySuccessPage extends StatelessWidget {
  const RegisterVerifySuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegisterInfoPage()), // Replace with your actual next page
      );
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                SizedBox(
                    child: Image.asset('assets/images/tick_dynamic_color.png')),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Почта подтверждена!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
