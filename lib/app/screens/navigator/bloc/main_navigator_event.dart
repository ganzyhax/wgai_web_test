part of 'main_navigator_bloc.dart';

@immutable
sealed class MainNavigatorEvent {}

class MainNavigatorLoad extends MainNavigatorEvent {}

// ignore: must_be_immutable
class MainNavigatorChangePage extends MainNavigatorEvent {
  int index;
  String? newsScrollId;
  bool? notificationCounselor;
  MainNavigatorChangePage(
      {required this.index, this.newsScrollId, this.notificationCounselor});
}

class MainNavigatorClear extends MainNavigatorEvent {}
