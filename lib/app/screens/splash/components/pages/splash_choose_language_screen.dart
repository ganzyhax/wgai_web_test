import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/api/api_utils.dart';
import 'package:wg_app/app/screens/login/login_screen.dart';
import 'package:wg_app/app/screens/splash/components/splash_button.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class SplashChooseLanguagePage extends StatefulWidget {
  const SplashChooseLanguagePage({super.key});

  @override
  State<SplashChooseLanguagePage> createState() =>
      _SplashChooseLanguagePageState();
}

int choosedIndex = -1;

class _SplashChooseLanguagePageState extends State<SplashChooseLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5.5,
                  ),
                  Text(
                    'Выберите язык',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Вы сможете поменять язык в любое время',
                    style: TextStyle(color: Colors.grey[500], fontSize: 17),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SpashButton(
                      onTap: () {
                        choosedIndex = 0;
                        setState(() {});
                      },
                      isSelected: (choosedIndex == 0) ? true : false,
                      title: 'English',
                      asset: 'assets/images/us-flag.png'),
                  SizedBox(
                    height: 11,
                  ),
                  SpashButton(
                      onTap: () {
                        choosedIndex = 1;
                        setState(() {});
                      },
                      isSelected: (choosedIndex == 1) ? true : false,
                      title: 'Русский',
                      asset: 'assets/images/ru-flag.png'),
                  SizedBox(
                    height: 11,
                  ),
                  SpashButton(
                      onTap: () {
                        choosedIndex = 2;
                        setState(() {});
                      },
                      isSelected: (choosedIndex == 2) ? true : false,
                      title: 'Қазақша',
                      asset: 'assets/images/kz-flag.png'),
                ],
              ),
              (choosedIndex == -1)
                  ? SizedBox()
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        CustomButton(
                          text: 'Начать',
                          onTap: () async {
                            if (choosedIndex == 0) {
                              await LocalUtils.setLanguage('en');
                              context.setLocale(const Locale('en'));
                            }
                            if (choosedIndex == 1) {
                              await LocalUtils.setLanguage('ru');
                              context.setLocale(const Locale('ru'));
                            }
                            if (choosedIndex == 2) {
                              await LocalUtils.setLanguage('kk');
                              context.setLocale(const Locale('kk'));
                            }
                            await LocalUtils.setFirstTime();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
