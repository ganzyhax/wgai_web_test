import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/screens/questionnaire/screens/questionnaire_screen.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class DescriptionQuestionnaireScreen extends StatefulWidget {
  const DescriptionQuestionnaireScreen({super.key});

  @override
  State<DescriptionQuestionnaireScreen> createState() =>
      _DescriptionQuestionnaireScreenState();
}

class _DescriptionQuestionnaireScreenState
    extends State<DescriptionQuestionnaireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
          builder: (context, state) {
            if (state is QuestionnaireSuccessState) {
              return Text(
                '${state.testId?.tr()}',
                style: AppTextStyle.titleHeading.copyWith(
                  color: AppColors.blackForText,
                ),
              );
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
      body: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
        builder: (context, state) {
          if (state is QuestionnaireSuccessState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width: 358,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.onTheBlue2,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${state.thumbnail}',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${state.testId?.tr()} - тест на тип личности',
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
                                '${state.timeLimit}',
                                style: AppTextStyle.heading3
                                    .copyWith(color: AppColors.blackForText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Container(
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
                                  'Описание'.tr(),
                                  style: AppTextStyle.bodyText
                                      .copyWith(color: AppColors.grayForText),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.description!
                                      .getLocalizedString(context),
                                  style: AppTextStyle.bodyText
                                      .copyWith(color: AppColors.blackForText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 86,
                  child: CustomButton(
                    text: 'Начать Тест'.tr(),
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
            );
          } else if (state is QuestionnaireLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionnaireErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }
}
