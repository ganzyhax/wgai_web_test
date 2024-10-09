import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  int selectedTabIndex = 0;
  bool isOpened = false;
  CommunityBloc() : super(CommunityInitial()) {
    on<CommunityEvent>((event, emit) {
      if (event is CommunityLoad) {
        emit(CommunityLoaded(
            selectedTabIndex: selectedTabIndex, isOpened: isOpened));
      }
      if (event is CommunitySelectTabIndex) {
        log('Tab selected');
        selectedTabIndex = event.selectedTabIndex;
        emit(CommunityLoaded(
            selectedTabIndex: selectedTabIndex, isOpened: isOpened));
      }
      if (event is CommunitySetIsOpened) {
        if (isOpened) {
          isOpened = false;
        } else {
          isOpened = true;
        }
        emit(CommunityLoaded(
            selectedTabIndex: selectedTabIndex, isOpened: isOpened));
      }
    });
  }
}
