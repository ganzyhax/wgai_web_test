import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/app/screens/profile_growth/widgets/growth_card.dart';
import 'package:wg_app/app/screens/profile_growth/widgets/growth_test_card.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ProfileGrowthScreen extends StatelessWidget {
  const ProfileGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.background,
          title: Text(
            'Личный рост',
            style: AppTextStyle.heading2,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                GrowthCard(
                  resultText: 'Next getting the ... ',
                  percentage: '40',
                ),
                SizedBox(
                  height: 15,
                ),
                GrowthTestCard(
                  title: 'INFJ (Itachi)',
                  subTitle: 'Результаты MBTI тестирования',
                )
              ],
            )));
  }
}
