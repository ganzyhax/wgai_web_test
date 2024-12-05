import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/ai/ai_screen.dart';
import 'package:wg_app/app/screens/community/community_screen.dart';
import 'package:wg_app/app/screens/personal_growth/personal_growth_screen.dart';
import 'package:wg_app/app/screens/profile/profile_screen.dart';
import 'package:wg_app/app/screens/resources/resources_screen.dart';
import 'package:wg_app/app/utils/amplitude.dart';

part 'main_navigator_event.dart';
part 'main_navigator_state.dart';

class MainNavigatorBloc extends Bloc<MainNavigatorEvent, MainNavigatorState> {
  MainNavigatorBloc() : super(MainNavigatorInitial()) {
    List screens = [
      // AiScreen(),
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
        if (event.index == 1) {
          index = event.index;
          if (event.newsScrollId != null) {
            index = event.index;
            screens = [
              // AiScreen(),
              PersonalGrowthScreen(),
              CommunityScreen(
                scrollId: event.newsScrollId,
              ),
              ResourcesScreen(),
              ProfileScreen(),
            ];
          }
          if (event.notificationCounselor == true) {
            index = event.index;
            screens = [
              // AiScreen(),
              PersonalGrowthScreen(),
              CommunityScreen(
                isCounsulant: true,
              ),
              ResourcesScreen(),
              ProfileScreen(),
            ];
          }
        } else {
          index = event.index;
        }
        if (index == 0) {
          AmplitudeFunc()
              .logEvent('Page Viewed', {'page_name': 'Personal Growth'});
        }
        if (index == 1) {
          AmplitudeFunc()
              .logEvent('Page Viewed', {'page_name': 'Counselor Growth'});
        }
        if (index == 2) {
          AmplitudeFunc().logEvent('Page Viewed', {'page_name': 'Resources'});
        }
        if (index == 3) {
          AmplitudeFunc().logEvent('Page Viewed', {'page_name': 'Profile'});
        }

        emit(MainNavigatorLoaded(index: index, screens: screens));
        screens = [
          // AiScreen(),
          PersonalGrowthScreen(),
          CommunityScreen(),
          ResourcesScreen(),
          ProfileScreen(),
        ];
      }
      if (event is MainNavigatorClear) {
        emit(MainNavigatorInitial());
      }
    });
  }
}
