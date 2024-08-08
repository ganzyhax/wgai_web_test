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
  String? _selectedAnswer;

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
                          padding: EdgeInsets.only(bottom: 20),
                          children: [
                            _buildQuestionWithAnswers(
                                state.questions[state.currentIndex]),
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
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _buildQuestionWithAnswers(Problems question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question?.ru ?? '',
          style: AppTextStyle.heading2.copyWith(
            color: AppColors.blackForText,
          ),
        ),
        const SizedBox(height: 8), // Separation between question and answers
        ...question.options!.map((option) {
          final isSelected =
              _selectedAnswer?.split(',').contains(option.answer?.ru) ?? false;
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0), // Separation between each answer
            child: ListTile(
              title: Text(
                option.answer?.ru ?? '',
                style: AppTextStyle.bodyText.copyWith(
                  color: AppColors.blackForText,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor:
                  isSelected ? AppColors.primary : AppColors.grayProgressBar,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                setState(() {
                  if (question.problemType == 'multiple_choice') {
                    if (_selectedAnswer
                            ?.split(',')
                            .contains(option.answer?.ru) ??
                        false) {
                      _selectedAnswer = _selectedAnswer!
                          .split(',')
                          .where((element) => element != option.answer?.ru)
                          .join(',');
                    } else {
                      _selectedAnswer = _selectedAnswer != null
                          ? '${_selectedAnswer!},${option.answer?.ru}'
                          : option.answer?.ru;
                    }
                  } else {
                    _selectedAnswer = option.answer?.ru;
                  }
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
            onTap: _selectedAnswer != null
                ? () {
                    context
                        .read<QuestionnaireBloc>()
                        .add(NextQuestion(_selectedAnswer!));
                    setState(() {
                      _selectedAnswer = null;
                    });
                  }
                : null,
            text: 'Next',
          ),
        ),
      ],
    );
  }
}
