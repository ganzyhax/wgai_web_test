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
  bool isLoadingComment = true;
  bool isLoading = true;
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsLoad) {
        isLoading = true;
        isLoadingComment = false;
        emit(NewsLoaded(
            isLoading: isLoading,
            userId: userId,
            data: (data == null) ? [] : data['data']['posts'],
            localLang: localLang,
            commentData:
                (commentData == null) ? [] : commentData['data']['comments']));

        localLang = await LocalUtils.getLanguage();
        data = await ApiClient.get('api/feed/posts/');
        userId = await LocalUtils.getUserId();
        if (data['success']) {
          isLoading = false;
          emit(NewsLoaded(
              isLoading: isLoading,
              userId: userId,
              data: (data == null) ? [] : data['data']['posts'],
              localLang: localLang,
              commentData: (commentData == null)
                  ? []
                  : commentData['data']['comments']));
        } else {
          isLoading = false;
          emit(NewsError(message: data['data']['message']));
          emit(NewsLoaded(
              isLoading: isLoading,
              data: (data == null) ? [] : data['data']['posts'],
              localLang: localLang,
              userId: userId,
              commentData: (commentData == null)
                  ? []
                  : commentData['data']['comments']));
        }
      }
      if (event is NewsGetCommentData) {
        isLoadingComment = true;
        emit(NewsLoaded(
            userId: userId,
            isLoading: isLoading,
            data: (data == null) ? [] : data['data']['posts'],
            localLang: localLang,
            commentData:
                (commentData == null) ? [] : commentData['data']['comments']));
        userId = await LocalUtils.getUserId();
        localLang = await LocalUtils.getLanguage();
        commentData = await ApiClient.get('api/feed/comments/' + event.postId);

        if (commentData['success']) {
          if (event.withUpdate == true) {
            add(NewsLoad());
          } else {
            isLoadingComment = false;
            emit(NewsLoaded(
                isLoading: isLoading,
                userId: userId,
                data: (data == null) ? [] : data['data']['posts'],
                localLang: localLang,
                commentData: (commentData == null)
                    ? []
                    : commentData['data']['comments']));
          }
        } else {}
      }
      if (event is NewsAddComment) {
        var req = await ApiClient.post('api/feed/comments/add', {
          "authorName": "Name",
          "text": event.commentText,
          "postId": event.postId
        });
        if (req['success']) {
          add(NewsGetCommentData(postId: event.postId, withUpdate: true));
        }
      }
      if (event is NewsRemoveComment) {
        var req = await ApiClient.post('api/feed/comments/remove', {
          "commentId": event.commentId,
        });
        if (req['success']) {
          add(NewsGetCommentData(postId: event.postId, withUpdate: true));
        }
      }
    });
  }
}
