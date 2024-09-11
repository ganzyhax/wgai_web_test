import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/profile/pages/profile_language/widgets/profile_language_card.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  String selectedLang = '';

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Call the async method
  }

  Future<void> _loadLanguage() async {
    selectedLang = await LocalUtils.getLanguage();
    log(selectedLang);
    setState(() {}); // Ensure UI updates after language is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          'Языки',
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.setLocale(Locale('kk'));
                  selectedLang = 'kk';
                  setState(() {});
                },
                child: ProfileLanguageCard(
                  asset: 'assets/icons/kz-flag.svg',
                  title: 'Қазақ',
                  isSelected: (selectedLang == 'kk') ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.setLocale(Locale('ru'));
                  selectedLang = 'ru';
                  setState(() {});
                },
                child: ProfileLanguageCard(
                  asset: 'assets/icons/ru-flag.svg',
                  title: 'Русский',
                  isSelected: (selectedLang == 'ru') ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.setLocale(Locale('en'));
                  selectedLang = 'en';
                  setState(() {});
                },
                child: ProfileLanguageCard(
                  asset: 'assets/icons/uk-flag.svg',
                  title: 'English',
                  isSelected: (selectedLang == 'en') ? true : false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
