import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class PersonalGrowthQuizModal extends StatefulWidget {
  final List<Map<String, dynamic>> quizData;

  const PersonalGrowthQuizModal({Key? key, required this.quizData})
      : super(key: key);

  @override
  _PersonalGrowthQuizModalState createState() =>
      _PersonalGrowthQuizModalState();
}

class _PersonalGrowthQuizModalState extends State<PersonalGrowthQuizModal> {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  List<int?> userAnswers = [];
  bool showCorrectAnswer = false;
  bool isFinished = false;
  @override
  void initState() {
    super.initState();
    userAnswers = List<int?>.filled(widget.quizData.length, null);
  }

  void onAnswerSelected(int answerIndex) {
    if (!showCorrectAnswer) {
      // Allow selection only if answers haven't been revealed yet
      setState(() {
        selectedAnswer = answerIndex;
        userAnswers[currentQuestionIndex] = answerIndex;
      });
    }
  }

  void onNextQuestion() {
    if (userAnswers[currentQuestionIndex] != null) {
      if (!showCorrectAnswer) {
        // Reveal correct/incorrect answers
        setState(() {
          showCorrectAnswer = true;
        });
      } else if (currentQuestionIndex < widget.quizData.length - 1) {
        // Move to the next question
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = userAnswers[currentQuestionIndex];
          showCorrectAnswer = false; // Reset for the new question
        });
      } else {
        _showResult(); // Show result in bottom modal
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an answer!")),
      );
    }
  }

  void _showResult() {
    int score = widget.quizData
        .where(
            (q) => userAnswers[widget.quizData.indexOf(q)] == q['correctIndex'])
        .length;

    Navigator.of(context).pop(true); // Return true after the test is completed

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return QuizResultModal(score: score, total: widget.quizData.length);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = widget.quizData[currentQuestionIndex];
    List<Map<String, String>> answers =
        (currentQuestion['answers'] as List<dynamic>)
            .map((answer) => Map<String, String>.from(answer as Map))
            .toList();
    int correctAnswerIndex = currentQuestion['correctIndex'];

    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(currentQuestion['question'][context.locale.languageCode],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedAnswer == index;
                bool isCorrect = index == correctAnswerIndex;
                bool isAnswered = userAnswers[currentQuestionIndex] != null;

                // Define color based on answer status
                Color answerColor = AppColors.whiteForText;
                if (showCorrectAnswer) {
                  if (isCorrect) {
                    answerColor = Colors.green; // Correct answer
                  } else if (isSelected && !isCorrect) {
                    answerColor = Colors.redAccent; // Incorrect answer
                  }
                } else if (isSelected) {
                  answerColor = AppColors.primary.withOpacity(0.2);
                }

                return GestureDetector(
                  onTap: () => onAnswerSelected(index),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: answerColor,
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child:
                        Text(answers[index][context.locale.languageCode] ?? ''),
                  ),
                );
              },
            ),
          ),
          CustomButton(
            text: showCorrectAnswer ||
                    currentQuestionIndex < widget.quizData.length - 1
                ? 'Дальше'
                : 'Закончить',
            onTap: onNextQuestion,
            isDisabled: selectedAnswer ==
                null, // Disable button if no answer is selected
          ),
        ],
      ),
    );
  }
}

class QuizResultModal extends StatelessWidget {
  final int score;
  final int total;

  const QuizResultModal({
    Key? key,
    required this.score,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height:
          MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 60),
          const SizedBox(height: 16),
          Text("Ваш результат",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Text("$score/$total",
              style: TextStyle(fontSize: 36, color: Colors.blue)),
          const SizedBox(height: 48),
          CustomButton(
            text: "Понятно",
            onTap: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
