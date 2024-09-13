import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/questionnaire/model/testing_model.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String testingCode;
  final String taskId;
  final bool isGuidanceTask;
  const QuestionnaireScreen({super.key, required this.testingCode, required this.taskId, required this.isGuidanceTask});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionnaireBloc>().add(LoadQuestionnaire(widget.testingCode));
  }

  Widget build(BuildContext context) {
    return BlocListener<QuestionnaireBloc, QuestionnaireState>(
      listener: (context, state) {
        if (state is QuestionnaireSubmittedState) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
            builder: (context, state) {
              if (state is QuestionnaireSuccessState) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    state.questionnaireTitle,
                    style: AppTextStyle.titleHeading.copyWith(
                      color: AppColors.blackForText,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  )
                );
              } else {
                return const Text("");
              }
            },
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
          ),
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
                            padding: const EdgeInsets.only(bottom: 232),
                            children: [
                              _buildQuestionWithAnswers(state.questions[state.currentIndex], state.selectedAnswerIndices),
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
              context.read<QuestionnaireBloc>().add(CompleteQuestionnaire(state.answers, widget.taskId, widget.isGuidanceTask));
              return const Center(child: Text(""));
            } else if (state is QuestionnaireErrorState) {
              return Center(child: Text(state.errorMessage));
            } else if (state is QuestionnaireSubmittedState) {
              return const Center(child: Text("Questionnaire Completed!"));
            } 
            return const Center(child: Text("Welcome to the Questionnaire!"));
          },
        ),
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

  Widget _buildQuestionWithAnswers(Problems question, List<int> selectedIndices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.problemType != 'poster')
          Text(
            question.question?.getLocalizedString(context) ?? '',
            style: AppTextStyle.heading2.copyWith(
              color: AppColors.blackForText,
            ),
          ),
        const SizedBox(height: 16),
        if (question.problemType == 'poster') Image.asset(question.image?.getLocalizedString(context) ?? ''),
        if (question.problemType != 'poster')
        const SizedBox(height: 16),
        if (question.problemType != 'poster')
        ...question.options!.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = selectedIndices.contains(index);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      option.answer?.getLocalizedString(context) ?? '',
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: isSelected ? AppColors.grayProgressBar : AppColors.blackForText),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor: isSelected ? AppColors.primary : AppColors.grayProgressBar,
              onTap: () {
                setState(
                  () {
                    context.read<QuestionnaireBloc>().add(AnswerQuestion(
                          index,
                          question.problemType == 'multiple-choice',
                          question.problemType == 'poster',
                        ));
                  },
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, QuestionnaireSuccessState state) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: CustomButton(
            height: 44,
            onTap: () {
              print("tapping");
              context.read<QuestionnaireBloc>().add(NextQuestion());
            },
            text: state.currentIndex == state.questions.length - 1 ? LocaleKeys.completion.tr() : LocaleKeys.next.tr(),
          ),
        ),
      ],
    );
  }
}