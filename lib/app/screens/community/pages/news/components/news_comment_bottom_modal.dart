import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/constants/app_colors.dart';

class NewsBottomModal extends StatelessWidget {
  final String postId;

  NewsBottomModal({
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    String getDayWord(int days) {
      if (days % 10 == 1 && days % 100 != 11) return 'день';
      if ([2, 3, 4].contains(days % 10) && ![12, 13, 14].contains(days % 100))
        return 'дня';
      return 'дней';
    }

    String getHourWord(int hours) {
      if (hours % 10 == 1 && hours % 100 != 11) return 'час';
      if ([2, 3, 4].contains(hours % 10) && ![12, 13, 14].contains(hours % 100))
        return 'часа';
      return 'часов';
    }

    String getMinuteWord(int minutes) {
      if (minutes % 10 == 1 && minutes % 100 != 11) return 'минута';
      if ([2, 3, 4].contains(minutes % 10) &&
          ![12, 13, 14].contains(minutes % 100)) return 'минуты';
      return 'минут';
    }

    String timeAgo(String dateString) {
      DateTime now = DateTime.now();
      DateTime dateTime = DateTime.parse(dateString);
      Duration difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} ${getDayWord(difference.inDays)} назад';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${getHourWord(difference.inHours)} назад';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${getMinuteWord(difference.inMinutes)} назад';
      } else {
        return 'только что';
      }
    }

    TextEditingController comment = TextEditingController();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocProvider(
        create: (context) =>
            NewsBloc()..add(NewsGetCommentData(postId: postId)),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoaded) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Комментарии (${state.commentData.length.toString()})',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: state.commentData.length,
                        itemBuilder: (context, index) {
                          final comment = state.commentData[index];
                          String time = timeAgo(comment['createdAt']);

                          return Container(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, bottom: 8),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.background),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqGK3diR3Zi-mnOXEaj-3ewmFyRYVxGzVzZw&s'),
                                    ),
                                    title: Text(
                                      comment['authorName']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(time),
                                    trailing: (comment['authorId'] ==
                                            state.userId)
                                        ? IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              BlocProvider.of<NewsBloc>(context)
                                                ..add(NewsRemoveComment(
                                                    postId: postId,
                                                    commentId: comment['_id']));
                                            },
                                          )
                                        : null),
                                Text(comment['text']!)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: comment,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      hintText: "Оставьте комментарий",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<NewsBloc>(context)
                                ..add(NewsAddComment(
                                    authorName: 'Tester',
                                    commentText: comment.text,
                                    postId: postId));
                              comment.text = '';
                            },
                            child: CircleAvatar(
                              radius: 23,
                              backgroundColor: AppColors.primary,
                              child: Center(
                                  child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
