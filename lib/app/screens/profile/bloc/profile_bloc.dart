import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    var data = [];
    var specialities;
    String selectedSpeciality = '';
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        specialities = await ApiClient.get('api/resources/kazSubjects');
        log(specialities.toString());
        emit(ProfileLoaded(
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality));
      }
      if (event is ProfileChangeUserData) {
        var req = await ApiClient.post('api/user/updateUserProfile', {
          "firstName": event.name,
          "lastName": event.surname,
        });
        if (req['success']) {
          emit(ProfileUpdatedSuccess());
          emit(ProfileLoaded(
              data: data,
              specialities: specialities['data']['subjects'],
              selectedSpeciality: selectedSpeciality));
        }
      }
      if (event is ProfileSetSpeciality) {
        log(specialities.toString());
        selectedSpeciality = event.value;
        emit(ProfileLoaded(
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality));
      }
    });
  }
}
