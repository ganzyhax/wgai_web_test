import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
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
              icon: SvgPicture.asset('assets/icons/x.svg'))
        ],
      ),
      body: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
        builder: (context, state) {
          if (state is QuestionnaireLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuestionnaireSuccessState) {
            final question = state.questions[state.currentIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.questionText,
                      style: AppTextStyle.heading2
                          .copyWith(color: AppColors.blackForText),
                    ),
                  ),
                  SizedBox(height: 37),
                  Expanded(
                    child: ListView.separated(
                      itemCount: question.answers.length,
                      itemBuilder: (context, index) {
                        final answer = question.answers[index];
                        final isSelected = answer == _selectedAnswer;
                        return ListTile(
                          title: Text(
                            answer,
                            style: AppTextStyle.bodyText
                                .copyWith(color: AppColors.blackForText),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          tileColor: isSelected
                              ? AppColors.primary
                              : AppColors.grayProgressBar,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          onTap: () {
                            setState(() {
                              _selectedAnswer = answer;
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<QuestionnaireBloc>()
                              .add(PreviousQuestion());
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
                                  _selectedAnswer = null;
                                }
                              : null,
                          text: 'Далее',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                ],
              ),
            );
          } else if (state is QuestionnaireCompletedState) {
            return Center(child: Text("Quiz Completed!"));
          } else if (state is QuestionnaireErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return Center(child: Text("Welcome to the Quiz!"));
        },
      ),
    );
  }
}
