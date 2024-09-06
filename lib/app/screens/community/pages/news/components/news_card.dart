import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/components/news_comment_bottom_modal.dart';
import 'package:wg_app/app/utils/helper_functions.dart';
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
    String formattedData = HelperFunctions().timeAgo(widget.data['updatedAt']);
    return GestureDetector(
      onTap: isContentLong
          ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : null,
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
                    widget.data['authorAvatarImage'],
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
                      widget.data['authorName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formattedData,
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
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    image: NetworkImage(
                        widget.data['thumbnail'][widget.localLang]),
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
                  BlocProvider.of<NewsBloc>(context)
                    ..add(NewsGetCommentData(postId: widget.data['_id']));
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return BlocProvider.value(
                        value: BlocProvider.of<NewsBloc>(context),
                        child: NewsBottomModal(
                          postId: widget.data['_id'],
                        ),
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
                      BlocProvider.of<NewsBloc>(context)
                        ..add(NewsGetCommentData(postId: widget.data['_id']));
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BlocProvider.value(
                            value: BlocProvider.of<NewsBloc>(
                                context), // Reuse the same Bloc
                            child: NewsBottomModal(
                              postId: widget.data['_id'],
                            ),
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
