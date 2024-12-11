import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/screens/psytest/screens/description_test_screen.dart';
import 'package:wg_app/app/screens/psytest/screens/results_screen.dart';
import 'package:wg_app/app/screens/psytest/screens/test_screen.dart';
import 'package:wg_app/app/screens/questionnaire/questionnaire_screen.dart';
import 'package:wg_app/app/utils/helper_functions.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/app/widgets/webview/html_loader.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultantCard extends StatefulWidget {
  final data;
  final String localLang;

  const ConsultantCard(
      {super.key, required this.data, required this.localLang});

  @override
  _ConsultantCardState createState() => _ConsultantCardState();
}

class _ConsultantCardState extends State<ConsultantCard> {
  bool isStarted = false;
  String selectedOption = '';
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String content = widget.data?['message']?[widget.localLang] ?? "";
    // String authorName = widget.data?['message']?[widget.localLang] ?? "";
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthorInfo(),
          SizedBox(height: 8),
          if (widget.data.containsKey('thumbnail'))
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  image:
                      NetworkImage(widget.data['thumbnail'][widget.localLang]),
                  placeholder: AssetImage(
                      'assets/images/placeholder.png'), // Local placeholder image
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors
                          .grey, // Background color when image fails to load
                      child: Center(
                        child: Text(
                          'Failed to load image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          SizedBox(height: 8),
          Text(content, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          _buildTaskSpecificWidget()
        ],
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          // child: Image.network(
          //   fit: BoxFit.cover,
          //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqGK3diR3Zi-mnOXEaj-3ewmFyRYVxGzVzZw&s',
          //   height: 50.0,
          //   width: 50.0,
          // ),
          child: Container(
            width: 50,
            height: 50,
            child: Image.asset(
              'assets/images/avatar_image.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey,
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data?['authorName'] ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                HelperFunctions()
                    .timeAgo(widget.data['createdAt'], widget.localLang),
                style: TextStyle(
                    color: AppColors.grayForText, fontWeight: FontWeight.w500)),
          ],
        )
      ],
    );
  }

  Widget _buildTaskSpecificWidget() {
    switch (widget.data['type']) {
      case 'textbox':
        if (!widget.data.containsKey('result')) {
          return _buildTextboxTask();
        } else if (widget.data['result']['textResponse'] == 'none') {
          return _buildTextboxTask();
        } else {
          return answerWidget(
              widget.data['result']['textResponse'].toString(),
              false,
              widget.data['result']['timeSubmitted'] ??
                  DateTime.now().toString());
        }
      case 'options':
        if (widget.data == null ||
            widget.data['result'] == null ||
            widget.data['result']['optionsResponse'].length == 0) {
          return _buildOptionsTask();
        } else {
          return answerWidget(
              widget.data['answerOptions']
                      [widget.data['result']['optionsResponse'][0][0]]
                  [widget.localLang],
              false,
              widget.data['result']['timeSubmitted'] ??
                  DateTime.now().toString());
        }
      case 'external-link':
        return CustomButton(
          text: LocaleKeys.by_link.tr(),
          onTap: () {
            BlocProvider.of<ConsultantBloc>(context)
              ..add(ConsultantUpdateStatus(
                  taskId: widget.data['_id'], status: 'complete'));
            _openExternalLink(widget.data['externalLink']);
          },
        );
      case 'psytest':
        return _buildQuestionnaireWidget();
      case 'questionnaire':
        return _buildQuestionnaireWidget();
      case 'announcement':
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTextboxTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isStarted)
          CustomButton(
            text: LocaleKeys.start.tr(),
            onTap: () {
              setState(() {
                isStarted = true;
              });
            },
            bgColor: Colors.grey[200],
            textColor: Colors.black,
          )
        else ...[
          Text(LocaleKeys.your_answer.tr(),
              style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: const Color.fromARGB(255, 189, 189, 189)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: answerController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.enter_answer.tr(),
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<ConsultantBloc>(context)
                    ..add(ConsultantTextBoxSubmitResponse(
                        taskId: widget.data['_id'],
                        answer: answerController.text));
                  setState(() {
                    answerController.text = '';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primary,
                    shape: BoxShape.rectangle,
                  ),
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildOptionsTask() {
    return Column(
      children: [
        Column(
          children: widget.data['answerOptions']
              .map<Widget>((option) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = option[widget.localLang];
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: selectedOption == option[widget.localLang]
                            ? Colors.blue[50]
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        option[widget.localLang],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 10),
        CustomButton(
          text: LocaleKeys.answer.tr(),
          onTap: selectedOption.isEmpty
              ? () {}
              : () {
                  int optionIndex = widget.data['answerOptions'].indexWhere(
                      (option) => option[widget.localLang] == selectedOption);
                  BlocProvider.of<ConsultantBloc>(context)
                    ..add(ConsultantOptionSubmitResponse(
                      taskId: widget.data['_id'],
                      answer: [optionIndex],
                    ));
                },
          isDisabled: selectedOption.isEmpty,
          textColor: Colors.white,
        ),
      ],
    );
  }

  answerWidget(String answer, bool isText, String time) {
    String formattedTime = HelperFunctions().timeAgo(time, widget.localLang);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.your_answer.tr(),
                style: AppTextStyle.heading2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(formattedTime,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500])),
              SizedBox(
                height: 5,
              ),
              (isText)
                  ? Text(answer)
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: const Color.fromARGB(255, 199, 199, 199), width: 1)),
        ),
        SizedBox(
          height: 10,
        ),
        CustomButton(
          text: LocaleKeys.change.tr(),
          icon: Icons.edit,
          iconColor: Colors.black,
          onTap: () {
            if (widget.data['type'] == 'textbox') {
              BlocProvider.of<ConsultantBloc>(context)
                ..add(ConsultantTextBoxSubmitResponse(
                    taskId: widget.data['_id'], answer: 'none'));
            } else {
              BlocProvider.of<ConsultantBloc>(context)
                ..add(ConsultantOptionSubmitResponse(
                    taskId: widget.data['_id'], answer: []));
            }
          },
          bgColor: Colors.grey[200],
          textColor: Colors.black,
        )
      ],
    );
  }

  Widget _buildPsyTestWidget() {
    return (widget.data['status'] == 'new')
        ? CustomButton(
            text: LocaleKeys.start_psytest.tr(),
            onTap: () {
              BlocProvider.of<ConsultantBloc>(context)
                ..add(ConsultantUpdateStatus(
                    taskId: widget.data['_id'], status: 'incomplete'));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionTestScreen(
                    sId: widget.data['_id'],
                  ),
                ),
              );
            },
            bgColor: AppColors.primary,
            textColor: Colors.white,
          )
        : (widget.data['status'] == 'incomplete')
            ? CustomButton(
                text: LocaleKeys.continue_button.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestScreen(
                        sId: widget.data['_id'],
                      ),
                    ),
                  );
                },
                bgColor: Colors.grey[200],
                textColor: Colors.black,
              )
            : CustomButton(
                text: LocaleKeys.results.tr(),
                onTap: () {
                  if (widget.data['result'] != null &&
                      widget.data['result']['interpretationLink'] != null)
                    (!kIsWeb)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HtmlWebView(
                                  contentCode: widget.data['result']
                                      ['interpretationLink'],
                                  isUrl: true,
                                  contentUrl: widget.data['result']
                                      ['interpretationLink'],
                                  contentUrlTitle: widget.data['result']
                                      ['subtitle'][widget.localLang],
                                  completionStatus: widget.data['status']),
                            ),
                          )
                        : HtmlLoader(
                            contentCode: widget.data['result']
                                ['interpretationLink'],
                            isUrl: true,
                            contentUrl: widget.data['result']
                                ['interpretationLink'],
                            contentUrlTitle: widget.data['result']['subtitle']
                                [widget.localLang],
                            completionStatus: widget.data['status']);
                },
                bgColor: Colors.grey[200],
                textColor: Colors.black,
              );
  }

  Widget _buildQuestionnaireWidget() {
    return (widget.data['status'] == 'new')
        ? CustomButton(
            text: LocaleKeys.start_psytest.tr(),
            onTap: () async {
              BlocProvider.of<ConsultantBloc>(context)
                ..add(ConsultantUpdateStatus(
                    taskId: widget.data['_id'], status: 'incomplete'));
              final res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionnaireScreen(
                      testingCode: widget.data['testingCode'],
                      taskId: widget.data['_id'],
                      isGuidanceTask: false),
                ),
              );
              if (res) {
                BlocProvider.of<ConsultantBloc>(context)
                  ..add(ConsultantUpdateStatus(
                      taskId: widget.data['_id'], status: 'complete'));
              }
            },
            bgColor: AppColors.primary,
            textColor: Colors.white,
          )
        : (widget.data['status'] == 'incomplete')
            ? CustomButton(
                text: LocaleKeys.continue_button.tr(),
                onTap: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionnaireScreen(
                          testingCode: widget.data['testingCode'],
                          taskId: widget.data['_id'],
                          isGuidanceTask: false),
                    ),
                  );

                  if (res) {
                    BlocProvider.of<ConsultantBloc>(context)
                      ..add(ConsultantUpdateStatus(
                          taskId: widget.data['_id'], status: 'complete'));
                    BlocProvider.of<ConsultantBloc>(context)
                      ..add(ConsultantCheckTask(taskId: widget.data['_id']));
                  }
                },
                bgColor: Colors.grey[200],
                textColor: Colors.black,
              )
            : CustomButton(
                text: (widget.data['result'] != null &&
                        widget.data['result']['interpretationLink'] != null)
                    ? LocaleKeys.results.tr()
                    : LocaleKeys.in_progress_check.tr(),
                onTap: () {
                  if (widget.data['result'] != null &&
                      widget.data['result']['interpretationLink'] != null)
                    (!kIsWeb)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HtmlWebView(
                                  contentCode: widget.data['result']
                                      ['interpretationLink'],
                                  isUrl: true,
                                  contentUrl: widget.data['result']
                                      ['interpretationLink'],
                                  contentUrlTitle: widget.data['result']
                                      ['subtitle'][widget.localLang],
                                  completionStatus: widget.data['status']),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HtmlLoader(
                                  contentCode: widget.data['result']
                                      ['interpretationLink'],
                                  isUrl: true,
                                  contentUrl: widget.data['result']
                                      ['interpretationLink'],
                                  contentUrlTitle: widget.data['result']
                                      ['subtitle'][widget.localLang],
                                  completionStatus: widget.data['status']),
                            ),
                          );
                },
                bgColor: Colors.grey[200],
                textColor: Colors.black,
              );
  }

  Future<void> _openExternalLink(String urlString) async {
    print(urlString);
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error as needed, e.g., show a snackbar or dialog to the user
    }
  }
}
