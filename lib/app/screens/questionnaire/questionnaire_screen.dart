import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wg_app/app/screens/questionnaire/model/testing_model.dart';
import 'package:wg_app/app/screens/questionnaire/bloc/questionnaire_bloc.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String testingCode;
  final String taskId;
  final bool isGuidanceTask;

  const QuestionnaireScreen({
    super.key,
    required this.testingCode,
    required this.taskId,
    required this.isGuidanceTask,
  });

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  late DateTime _startTime; // To store the start time
  final List<Map<String, dynamic>> _chatMessages = []; // Chat message history
  final ScrollController _scrollController =
      ScrollController(); // ScrollController
  bool _isTyping = false; // Typing indicator
  int? _lastShownQuestionIndex; // Track last shown question index
  bool _showLoading = false;
  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    context
        .read<QuestionnaireBloc>()
        .add(LoadQuestionnaire(widget.testingCode));
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose ScrollController
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showQuestion(Problems question, int index) async {
    if (_lastShownQuestionIndex == index) return; // Prevent duplicate show
    _lastShownQuestionIndex = index; // Update last shown question
    setState(() {
      _showLoading = true;
      _isTyping = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _chatMessages.add({'isQuestion': true, 'text': ''});
      _showLoading = false;
    });

    String fullText = question.question?.getLocalizedString(context) ?? '';
    int messageIndex = _chatMessages.length - 1;

    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _chatMessages[messageIndex]['text'] += fullText[i];
      });
      _scrollToBottom();
    }

    setState(() {
      _isTyping = false;
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionnaireBloc, QuestionnaireState>(
      listener: (context, state) {
        if (state is QuestionnaireSubmittedState) {
          final Duration elapsedTime = DateTime.now().difference(_startTime);
          final minutes = elapsedTime.inSeconds ~/ 60;
          final seconds = elapsedTime.inSeconds % 60;
          print('Test completed in $minutes minutes and $seconds seconds');
          Navigator.of(context).pop(true);
        } else if (state is QuestionnaireSuccessState && !_isTyping) {
          _showQuestion(
              state.questions[state.currentIndex], state.currentIndex);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
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
                    ));
              } else {
                return const Text("");
              }
            },
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
          ),
        ),
        body: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
          builder: (context, state) {
            if (state is QuestionnaireLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuestionnaireSuccessState) {
              return Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  _buildProgressBar(state),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController, // Attach ScrollController
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _chatMessages.length + (_showLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _chatMessages.length && _showLoading) {
                          return _buildTypingIndicator();
                        }
                        final message = _chatMessages[index];
                        return _buildChatMessage(message);
                      },
                    ),
                  ),
                  BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
                    builder: (context, state) {
                      if (state is QuestionnaireSuccessState) {
                        log(state.questions[state.currentIndex].question!.kk
                            .toString());
                        return (!_isTyping)
                            ? _buildAnswerOptions(
                                state.questions[state.currentIndex],
                                state.selectedAnswerIndices,
                              )
                            : SizedBox();
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              );
            } else if (state is QuestionnaireCompletedState) {
              context.read<QuestionnaireBloc>().add(CompleteQuestionnaire(
                  state.answers, widget.taskId, widget.isGuidanceTask));
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

  Widget _buildChatMessage(Map<String, dynamic> message) {
    final bool isQuestion = message['isQuestion'];
    _scrollToBottom();
    return Align(
      alignment: isQuestion ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isQuestion ? AppColors.grayProgressBar : AppColors.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message['text'],
          style: AppTextStyle.bodyText.copyWith(
            color: isQuestion ? AppColors.blackForText : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    _scrollToBottom();
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          '•••',
          style: AppTextStyle.bodyText.copyWith(
            color: Colors.white,
          ),
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

  Widget _buildAnswerOptions(Problems question, List<int> selectedIndices) {
    log(question.problemType.toString());
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      color: AppColors.background,
      child: Column(
        // spacing: 8.0,
        // runSpacing: 8.0,
        children: question.options!.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          log(option.answer!.kk.toString());
          return GestureDetector(
            onTap: () {
              setState(() {
                _chatMessages.add({
                  'isQuestion': false,
                  'text': option.answer?.getLocalizedString(context) ?? '',
                });
                context.read<QuestionnaireBloc>().add(AnswerQuestion(
                      index,
                      question.problemType == 'multiple-choice',
                      question.problemType == 'poster',
                    ));
                context.read<QuestionnaireBloc>().add(NextQuestion());
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primary),
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  option.answer?.getLocalizedString(context) ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
