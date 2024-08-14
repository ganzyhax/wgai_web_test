part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoaded extends NewsState {
  String localLang;
  String userId;
  var commentData;
  var data;
  NewsLoaded(
      {required this.data,
      required this.localLang,
      required this.commentData,
      required this.userId});
}

final class NewsError extends NewsState {
  String message;
  NewsError({required this.message});
}
