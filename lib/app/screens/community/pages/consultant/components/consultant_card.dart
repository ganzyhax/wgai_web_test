import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/components/news_comment_bottom_modal.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    log(widget.data.toString());
    String content = widget.data['message'][widget.localLang];
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adilet Alibek',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '5 минут назад',
                      style: TextStyle(
                          color: AppColors.grayForText,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            (widget.data['type'] == 'textbox')
                ? (!isStarted)
                    ? CustomButton(
                        text: 'Начать',
                        onTap: () {
                          setState(() {
                            isStarted = true;
                          });
                        },
                        bgColor: Colors.grey[200],
                        textColor: Colors.black,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ваш ответ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 189, 189, 189),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Введите ответ',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors
                                      .primary, // Change to your desired color
                                  shape: BoxShape.rectangle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Define your button action here
                                  },
                                  icon: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
