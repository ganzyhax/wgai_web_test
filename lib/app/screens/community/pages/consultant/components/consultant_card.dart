import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/consultant/bloc/consultant_bloc.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

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
    String content = widget.data['message'][widget.localLang];
    return GestureDetector(
      onTap: () {
        if (widget.data['type'] == 'external-link') {
          _openExternalLink(widget.data['link']);
        } else if (widget.data['type'] == 'psytest' ||
            widget.data['type'] == 'questionnaire') {}
      },
      child: Container(
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
            Text(content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildTaskSpecificWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            fit: BoxFit.cover,
            'https://s3-alpha-sig.figma.com/img/ee49/4a31/715413ba4192fbdaa3060b5131dc5b83?Expires=1724630400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=I4muFlR0nJC1vuejG7gwsE~tPI0SOOwf5XosSntHAvtA1utUNq5KzrVNOqbea~HvWeZnWVJFLdyn335Oqi1Fela9l4g-eYovxZucHRFZtBtGc78vYDZC-AeSOxdpdTb8Cz~JFX2Umv6d7nP4yQN6dPjoxbBaSKEtTo7hdDKmevDpBZwAvzPMgZjkaMM8JyAI8hCKUdLxM7KGPofOx63O0uA1-Jjc8q-I~Gpn5ujvxWISMh2EM1iJREdDkkISEJLuyKFFWXjp1NafF0~Pw61KO0z3jewh35sI0FsD3Uc31iqwnj~aYv1nHZCqRcT~UX38hZycwno7y2sG71z4V2swnA__',
            height: 50.0,
            width: 50.0,
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adilet Alibek',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('5 минут назад',
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
        if (widget.data['result']['optionsResponse'].length == 0) {
          return _buildTextboxTask();
        } else {
          return answerWidget(
              '', false, widget.data['result']['timeSubmitted']);
        }
      case 'options':
        log(widget.data.toString());
        if (widget.data['result']['optionsResponse'].length == 0) {
          return _buildOptionsTask();
        } else {
          return answerWidget(
              widget.data['answerOptions']
                      [widget.data['result']['optionsResponse'][0][0]]
                  [widget.localLang],
              false,
              widget.data['result']['timeSubmitted']);
        }
      case 'external-link':
      case 'psytest':
      case 'questionnaire':
        return (widget.data['status'] == 'new')
            ? CustomButton(
                text: 'Перейти',
                onTap: () {
                  BlocProvider.of<ConsultantBloc>(context)
                    ..add(ConsultantUpdateStatus(
                        taskId: widget.data['_id'], status: 'incomplete'));
                },
                bgColor: AppColors.primary,
                textColor: Colors.white,
              )
            : (widget.data['status'] == 'incomplete')
                ? CustomButton(
                    text: 'Продолжить',
                    onTap: () {
                      BlocProvider.of<ConsultantBloc>(context)
                        ..add(ConsultantUpdateStatus(
                            taskId: widget.data['_id'], status: 'incomplete'));
                    },
                    bgColor: Colors.grey[200],
                    textColor: Colors.black,
                  )
                : CustomButton(
                    text: 'Результаты',
                    onTap: () {},
                    bgColor: Colors.grey[200],
                    textColor: Colors.black,
                  );
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
            text: 'Начать',
            onTap: () {
              setState(() {
                isStarted = true;
              });
            },
            bgColor: Colors.grey[200],
            textColor: Colors.black,
          )
        else ...[
          Text('Ваш ответ', style: TextStyle(color: Colors.grey[600])),
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите ответ',
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primary,
                  shape: BoxShape.rectangle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_upward, color: Colors.white),
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
          text: 'Ответить',
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ваш ответ',
                style: AppTextStyle.heading2,
              ),
              SizedBox(
                height: 5,
              ),
              Text('5 минут назад',
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
          text: 'Изменить',
          onTap: () {},
          bgColor: Colors.grey[200],
          textColor: Colors.black,
        )
      ],
    );
  }

  void _openExternalLink(String url) {}
}
