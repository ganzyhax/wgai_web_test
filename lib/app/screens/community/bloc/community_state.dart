part of 'community_bloc.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

final class CommunityLoaded extends CommunityState {
  int selectedTabIndex;
  CommunityLoaded({required this.selectedTabIndex});
}
