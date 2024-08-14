import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/components/news_comment_bottom_modal.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';

class NewsCard extends StatefulWidget {
  final data;
  final String localLang;

  const NewsCard({super.key, required this.data, required this.localLang});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String content = widget.data['content'][widget.localLang] ?? '';
    String title = widget.data['title'][widget.localLang] ?? '';
    String truncatedContent =
        content.length > 60 ? content.substring(0, 60) + '...' : content;
    bool isContentLong = content.length > 60;

    return GestureDetector(
      onTap: isContentLong
          ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : null, // Only allow tapping if content is long
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
            if (widget.data.containsKey('thumbnail'))
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.data['thumbnail'][widget.localLang]),
                        fit: BoxFit.cover)),
              ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _isExpanded ? content : truncatedContent,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            if (_isExpanded)
              CustomButton(
                text: 'Коментарии' +
                    ' (' +
                    widget.data['commentCounter'].toString() +
                    ')',
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return NewsBottomModal(
                        postId: widget.data['_id'],
                      );
                    },
                  );
                },
                bgColor: Colors.grey[300],
              )
            else
              Row(
                children: [
                  Text(
                    widget.data['commentCounter'].toString(),
                    style: TextStyle(color: AppColors.grayForText),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return NewsBottomModal(
                            postId: widget.data['_id'],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.comment,
                      color: AppColors.grayForText,
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
