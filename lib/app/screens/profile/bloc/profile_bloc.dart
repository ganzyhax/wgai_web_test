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
    var fullName = "";
    String selectedSpeciality = '';
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        var sss = await ApiClient.get('api/portfolio/myUniversity');
        // log(sss.toString());
        specialities = await ApiClient.get('api/resources/kazSubjects');
        // log(specialities.toString());
        final userProfile = await ApiClient.get('api/user');
        if (userProfile['success']) {
          fullName = userProfile['data']['firstName'] +
              " " +
              userProfile['data']['lastName'];
        }

        emit(
          ProfileLoaded(
              data: data,
              specialities: specialities['data']['subjects'],
              selectedSpeciality: selectedSpeciality,
              fullName: fullName),
        );
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
              selectedSpeciality: selectedSpeciality,
              fullName: fullName));
        }
      }
      if (event is ProfileSetSpeciality) {
        selectedSpeciality = event.value;
        emit(ProfileLoaded(
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality,
            fullName: fullName));
      }
    });
  }
}
