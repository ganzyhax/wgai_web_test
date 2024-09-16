import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashStartScreen extends StatelessWidget {
  const SplashStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              Container(
                // margin: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    // Shadow

                    // Image
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor:
                            0.5, // This will cut the image vertically by 20%
                        child: Image.asset(
                          'assets/images/splash_phone.png',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40, // Height of the shadow
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.9),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 9,
                    right: MediaQuery.of(context).size.width / 9),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          LocaleKeys.advice.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyle.heading1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          LocaleKeys.personalAI.tr(),
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              CustomButton(
                text: LocaleKeys.start.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
