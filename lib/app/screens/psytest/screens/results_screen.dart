import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/community/pages/news/news_screen.dart';
import 'package:wg_app/app/screens/consultant/consultant_screen.dart';
import 'package:wg_app/app/screens/personal_growth/personal_growth_screen.dart';
import 'package:wg_app/app/screens/psytest/bloc/test_bloc.dart';
import 'package:wg_app/app/screens/psytest/widgets/result_container.dart';
import 'package:wg_app/app/widgets/alert/custom_alert.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class ResultsScreen extends StatelessWidget {
  final String sId;
  const ResultsScreen({required this.sId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'MBTI',
          style: AppTextStyle.heading2,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/x.svg'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResultContainer(title: 'Защитник \n(ISFJ)'),
                SizedBox(height: 24),
                CustomButton(
                  text: LocaleKeys.retake_test.tr(),
                  onTap: () {},
                  textColor: AppColors.blackForText,
                  bgColor: AppColors.onTheBlue2,
                  icon: Icons.refresh,
                  iconColor: AppColors.blackForText,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Защитник',
                    style: AppTextStyle.heading2
                        .copyWith(color: AppColors.blackForText),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Защитники (ISFJ) помогают вращать мир своим простым и сдержанным подходом. Люди с таким типом личности, трудолюбивые и преданные своему делу, глубоко чувствуют ответственность перед окружающими. Защитники опаздывают к назначенному сроку, не забывают дни рождения и особые дни, сохраняют традиции и оказывают заботу и поддержку близким.',
                  style: AppTextStyle.bodyText
                      .copyWith(color: AppColors.blackForText),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Защитник',
                    style: AppTextStyle.heading2
                        .copyWith(color: AppColors.blackForText),
                  ),
                ),
                Text(
                  'Но они редко требуют, чтобы другие видели и признавали то, что они сделали, вместо этого предпочитая действовать за кулисами.Это человек, обладающий разносторонними способностями. Несмотря на то, что защитники чувствительны и заботливы, они обладают отличными аналитическими способностями и следят за маленькими моментами. Кроме того, несмотря на свою сдержанность, они обладают хорошо развитыми навыками и прочными социальными отношениями. Защитники на самом деле состоят из комбинации различных способностей, и их различные сильные стороны сияют даже в самых элементарных аспектах их повседневной жизни.',
                  style: AppTextStyle.bodyText
                      .copyWith(color: AppColors.blackForText),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 86,
            child: CustomButton(
              text: LocaleKeys.completion.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalGrowthScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
