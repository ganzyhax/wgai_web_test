import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/universities/bloc/universities_bloc.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/constants/app_hive_constants.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    var data = [];
    var specialities;
    var fullName = "";
    var selectedSpeciality;
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        var sss = await ApiClient.get('api/portfolio/myUniversity');
        log(sss.toString());
        specialities = await ApiClient.get('api/resources/kazSubjects');
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
      if (event is ProfileAddMyCareerBookmark) {
        var res = await ApiClient.post('api/portfolio/myCareer/addBookmark',
            {'occupationCode': event.occupationCode});
        if (res['success']) {
          await BookmarkData().addItem(AppHiveConstants.professions, {
            'id': event.occupationCode,
            'data': {'title': event.title, 'areaIconCode': event.areaIconCode}
          });
        } else {
          emit(ProfileUpdateCareerError());
        }
        emit(ProfileLoaded(
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality,
            fullName: fullName));
      }
      if (event is ProfileDeleteMyCareerBookmark) {
        var res = await ApiClient.post('api/portfolio/myCareer/removeBookmark',
            {'occupationCode': event.occupationCode});

        if (res['success']) {
          await BookmarkData()
              .removeItem(AppHiveConstants.professions, event.occupationCode);
        } else {
          emit(ProfileUpdateCareerError());
        }
        emit(ProfileLoaded(
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality,
            fullName: fullName));
      }
    });
  }
}
