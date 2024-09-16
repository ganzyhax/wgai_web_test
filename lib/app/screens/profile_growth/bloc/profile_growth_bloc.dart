import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'profile_growth_event.dart';
part 'profile_growth_state.dart';

class ProfileGrowthBloc extends Bloc<ProfileGrowthEvent, ProfileGrowthState> {
  ProfileGrowthBloc() : super(ProfileGrowthInitial()) {
    var data;
    on<ProfileGrowthEvent>((event, emit) async {
      if (event is ProfileGrowthLoad) {
        data = await ApiClient.get('api/portfolio/myPersonalGrowth');
        log(data.toString());
        if (data['success']) {
          emit(ProfileGrowthLoaded(data: data['data']['myPersonalGrowth']));
        } else {
          emit(ProfileGrowthError(errorText: data['data']['message']));
          emit(ProfileGrowthLoaded(data: data));
        }
      }
    });
  }
}
