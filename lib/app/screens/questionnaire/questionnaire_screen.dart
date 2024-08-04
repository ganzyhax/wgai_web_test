import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc_bloc.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
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
      // body: BlocBuilder<QuestionnaireBlocBloc, QuestionnaireBlocState>(
      //   builder: (context, state) {
      //     if (state is QuestionnaireLoadingState) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (state is QuestionnaireSuccessState) {
      //       final question = state.questions[state.currentIndex];
      //       return Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               height: 8,
      //               width: 195,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(16),
      //                 color: AppColors.grayProgressBar,
      //               ),
      //               clipBehavior: Clip.hardEdge,
      //               child: LinearProgressIndicator(
      //                 value: state.currentIndex / state.questions.length,
      //                 backgroundColor: Colors.transparent,
      //                 valueColor:
      //                     AlwaysStoppedAnimation<Color>(AppColors.primary),
      //               ),
      //             ),
      //             SizedBox(height: 24),
      //             Text(
      //               question.questionText,
      //               style: AppTextStyle.heading2
      //                   .copyWith(color: AppColors.blackForText),
      //             ),
      //             // Expanded(
      //             //   child: ListView(
      //             //     children: question.answers.map(
      //             //       (answer) {
      //             //         return ElevatedButton(
      //             //           onPressed: () {
      //             //             context
      //             //                 .read<QuestionnaireBlocBloc>()
      //             //                 .add(AnswersQuestions(answer));
      //             //           },
      //             //           child: Text(answer),
      //             //         );
      //             //       },
      //             //     ).toList(),
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       );
      //     } else if (state is QuestionnaireCompletedState) {
      //       return Center(child: Text("Quiz Completed!"));
      //     } else if (state is QuestionnaireErrorState) {
      //       return Center(child: Text(state.errorMessage));
      //     }
      //     return Center(child: Text("Welcome to the Quiz!"));
      //   },
      // ),
    );
  }
}
