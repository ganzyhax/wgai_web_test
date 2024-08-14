part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

final class NewsLoad extends NewsEvent {}

final class NewsGetCommentData extends NewsEvent {
  final String postId;
  NewsGetCommentData({required this.postId});
}

final class NewsAddComment extends NewsEvent {
  final String commentText;
  final String postId;
  final String authorName;
  NewsAddComment(
      {required this.commentText,
      required this.authorName,
      required this.postId});
}

final class NewsRemoveComment extends NewsEvent {
  final String commentId;
  final String postId;
  NewsRemoveComment({required this.commentId, required this.postId});
}
