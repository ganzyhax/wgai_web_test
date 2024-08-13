import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  Key _listViewKey = UniqueKey();

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
      body: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
        builder: (context, state) {
          if (state is QuestionnaireLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionnaireSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildProgressBar(state),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView(
                          key: _listViewKey,
                          padding: EdgeInsets.only(bottom: 232),
                          children: [
                            _buildQuestionWithAnswers(
                                state.questions[state.currentIndex],
                                state.selectedAnswer),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: _buildNavigationButtons(context, state),
                  ),
                ],
              ),
            );
          } else if (state is QuestionnaireCompletedState) {
            return const Center(child: Text("Quiz Completed!"));
          } else if (state is QuestionnaireErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text("Welcome to the Quiz!"));
        },
      ),
    );
  }

  Widget _buildProgressBar(QuestionnaireSuccessState state) {
    return Container(
      height: 8,
      width: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.grayProgressBar,
      ),
      clipBehavior: Clip.hardEdge,
      child: LinearProgressIndicator(
        value: state.currentIndex / state.questions.length,
        backgroundColor: Colors.transparent,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _buildQuestionWithAnswers(Problems question, String? selectedAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question?.getLocalizedString(context) ?? '',
          style: AppTextStyle.heading2.copyWith(
            color: AppColors.blackForText,
          ),
        ),
        const SizedBox(height: 16),
        ...question.options!.map((option) {
          final isSelected =
              selectedAnswer == option.answer?.getLocalizedString(context);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: Text(option.answer?.getLocalizedString(context) ?? ''),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor:
                  isSelected ? AppColors.primary : AppColors.grayProgressBar,
              onTap: () {
                setState(() {
                  context.read<QuestionnaireBloc>().add(AnswersQuestions(
                        option.answer?.getLocalizedString(context) ?? '',
                        false,
                      ));
                });
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildNavigationButtons(
      BuildContext context, QuestionnaireSuccessState state) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            context.read<QuestionnaireBloc>().add(PreviousQuestion());
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(71, 44),
            backgroundColor: AppColors.grayProgressBar,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          label: SvgPicture.asset("assets/icons/arrow-left.svg"),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: CustomButton(
            height: 44,
            onTap: () {
              context
                  .read<QuestionnaireBloc>()
                  .add(NextQuestion(state.selectedAnswer ?? ''));
            },
            text: state.currentIndex == state.questions.length - 1
                ? "Потвердить"
                : "Далее",
          ),
        ),
      ],
    );
  }
}