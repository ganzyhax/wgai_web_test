import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/questionnaire/questionnaire_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/constants/app_colors.dart';

class QuestionnaireStaticScreen extends StatefulWidget {
  const QuestionnaireStaticScreen({super.key});

  @override
  State<QuestionnaireStaticScreen> createState() =>
      _QuestionnaireStaticScreenState();
}

class _QuestionnaireStaticScreenState extends State<QuestionnaireStaticScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'MBTI',
          style: AppTextStyle.titleHeading.copyWith(
            color: AppColors.blackForText,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset('assets/images/course-image.png'),
                const SizedBox(height: 16),
                Text(
                  'MBTI - тест на тип личности',
                  style: AppTextStyle.heading2
                      .copyWith(color: AppColors.blackForText),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.onTheBlue2,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Выполнить до:',
                          style: AppTextStyle.bodyText
                              .copyWith(color: AppColors.grayForText),
                        ),
                        Text(
                          '21.02.2024 20:00', // TODO : Дергать время с backa
                          style: AppTextStyle.heading3
                              .copyWith(color: AppColors.blackForText),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.onTheBlue2,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Описание',
                              style: AppTextStyle.bodyText
                                  .copyWith(color: AppColors.grayForText),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Тестирование MBTI проводится по методике самоотчёта (англ. Self-Report Inventory): опросник, в котором испытуемый самостоятельно заполняет опросную форму — выбирает один из двух ответов на каждый вопрос. Центр ведёт исследовательскую деятельность и готовит специалистов по применению MBTI. Широкую популярность тест MBTI и типология Майерс — Бриггс стали приобретать после того, как в 1975 году права на его продажу получила Consulting Psychologists Press, занявшаяся его продвижением. В том же 1975 году под эгидой CAPT была проведена первая конференция, посвящённая типологии Майерс — Бриггс, которая и теперь проводится каждые 2 года',
                              style: AppTextStyle.bodyText
                                  .copyWith(color: AppColors.blackForText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 86,
            child: CustomButton(
              text: 'Начать Тест',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionnaireScreen(),
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
