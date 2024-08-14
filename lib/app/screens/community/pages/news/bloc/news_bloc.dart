import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/api/auth_utils.dart';
import 'package:wg_app/app/utils/local_utils.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  var data;
  var commentData;
  String localLang = 'ru';
  String userId = '';
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsLoad) {
        localLang = await LocalUtils.getLanguage();
        data = await ApiClient.get('api/feed/posts/');
        userId = await LocalUtils.getUserId();
        if (data['success']) {
          emit(NewsLoaded(
              userId: userId,
              data: data['data']['posts'],
              localLang: localLang,
              commentData: commentData));
        } else {
          emit(NewsError(message: data['data']['message']));
          emit(NewsLoaded(
              data: data['data']['posts'],
              localLang: localLang,
              userId: userId,
              commentData: commentData));
        }
      }
      if (event is NewsGetCommentData) {
        userId = await LocalUtils.getUserId();
        localLang = await LocalUtils.getLanguage();
        commentData = await ApiClient.get('api/feed/comments/' + event.postId);
        if (commentData['success']) {
          emit(NewsLoaded(
              userId: userId,
              data: [],
              localLang: localLang,
              commentData: commentData['data']['comments']));
        } else {}
      }
      if (event is NewsAddComment) {
        var req = await ApiClient.post('api/feed/comments/add', {
          "authorName": "Name",
          "text": event.commentText,
          "postId": event.postId
        });
        if (req['success']) {
          add(NewsGetCommentData(postId: event.postId));
        }
      }
      if (event is NewsRemoveComment) {
        var req = await ApiClient.post('api/feed/comments/remove', {
          "commentId": event.commentId,
        });
        if (req['success']) {
          add(NewsGetCommentData(postId: event.postId));
        }
      }
    });
  }
}
