import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:wg_app/app/screens/community/community_screen.dart';
import 'package:wg_app/app/screens/consultant/consultant_screen.dart';
import 'package:wg_app/app/screens/personal_growth/personal_growth_screen.dart';
import 'package:wg_app/app/screens/profile/profile_screen.dart';
import 'package:wg_app/app/screens/resources/resources_screen.dart';

part 'main_navigator_event.dart';
part 'main_navigator_state.dart';

class MainNavigatorBloc extends Bloc<MainNavigatorEvent, MainNavigatorState> {
  MainNavigatorBloc() : super(MainNavigatorInitial()) {
    List screens = [
      PersonalGrowthScreen(),
      CommunityScreen(),
      ResourcesScreen(),
      ProfileScreen(),
    ];
    int index = 0;
    on<MainNavigatorEvent>((event, emit) async {
      if (event is MainNavigatorLoad) {
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }

      if (event is MainNavigatorChangePage) {
        index = event.index;
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }
      if (event is MainNavigatorClear) {
        emit(MainNavigatorInitial());
      }
    });
  }
}
