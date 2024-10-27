part of 'community_bloc.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

final class CommunityLoaded extends CommunityState {
  int selectedTabIndex;
  bool isOpened;
  CommunityLoaded({required this.selectedTabIndex, required this.isOpened});
}
