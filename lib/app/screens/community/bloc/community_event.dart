part of 'community_bloc.dart';

@immutable
sealed class CommunityEvent {}

final class CommunityLoad extends CommunityEvent {}

final class CommunitySelectTabIndex extends CommunityEvent {
  int selectedTabIndex;
  CommunitySelectTabIndex({required this.selectedTabIndex});
}

final class CommunitySetIsOpened extends CommunityEvent {}
