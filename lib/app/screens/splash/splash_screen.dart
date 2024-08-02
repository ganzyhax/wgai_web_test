import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/data/const/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_image.png'),
            SizedBox(
              height: 25,
            ),
            Text('WEGLOBAL.AI'),
            SizedBox(
              height: 25,
            ),
            Text(
              LocaleKeys.splash_subtitle.tr(),
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
