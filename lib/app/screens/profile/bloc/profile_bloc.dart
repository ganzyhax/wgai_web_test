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
    var data;
    var specialities;
    var fullName = "";
    var selectedSpeciality;
    var selectedForeignUniversities;
    var selectedUniSpecId = '';
    String selectedSubjectId = '';
    List<String> keys = [
      'safeChoice',
      'targetChoice1',
      'targetChoice2',
      'dreamChoice'
    ];
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        final userProfile = await ApiClient.get('api/user');
        if (userProfile['success']) {
          if (userProfile['data'].containsKey('firstName')) {
            fullName = userProfile['data']['firstName'] +
                " " +
                userProfile['data']['lastName'];
          } else {
            fullName = '';
          }
        }
        emit(
          ProfileLoaded(
              selectedForeignUniversities: selectedForeignUniversities,
              data: [],
              specialities: [],
              selectedSpeciality: selectedSpeciality,
              fullName: fullName),
        );
      }
      if (event is ProfileUniversitiesLoad) {
        emit(ProfileLoading());
        if (specialities == null) {
          data = await ApiClient.get('api/portfolio/myUniversity');
          specialities = await ApiClient.get('api/resources/kazSubjects');
          selectedForeignUniversities =
              data['data']['myUniversity']['foreignUniversities'];
          if (data['data']['myUniversity'].containsKey('kazUniversities')) {
            if (data['data']['myUniversity']['kazUniversities']
                .containsKey('profileSubject')) {
              selectedSubjectId = data['data']['myUniversity']
                  ['kazUniversities']['profileSubject']['code'];
              selectedSpeciality = data['data']['myUniversity']
                  ['kazUniversities']['profileSubject']['name'];
            }
            List<Map<String, dynamic>?> resultList = keys
                .map((key) {
                  final choice =
                      data['data']['myUniversity']['kazUniversities'][key];
                  if (choice != null) {
                    return {'id': key, 'data': choice};
                  }
                  return null;
                })
                .where((item) => item != null) // Filter out null values
                .toList();
            await BookmarkData()
                .loadData(AppHiveConstants.kzUniversities, resultList);
          }
          emit(
            ProfileLoaded(
                selectedForeignUniversities: selectedForeignUniversities,
                data: data['data']['myUniversity'],
                specialities: specialities['data']['subjects'],
                selectedSpeciality: selectedSpeciality,
                fullName: fullName),
          );
        } else {
          emit(
            ProfileLoaded(
                selectedForeignUniversities: selectedForeignUniversities,
                data: data['data']['myUniversity'],
                specialities: specialities['data']['subjects'],
                selectedSpeciality: selectedSpeciality,
                fullName: fullName),
          );
        }
      }
      if (event is ProfileChangeUserData) {
        var req = await ApiClient.post('api/user/updateUserProfile', {
          "firstName": event.name,
          "lastName": event.surname,
        });
        if (req['success']) {
          emit(ProfileUpdatedSuccess());
          emit(ProfileLoaded(
              selectedForeignUniversities: selectedForeignUniversities,
              data: data,
              specialities: specialities['data']['subjects'],
              selectedSpeciality: selectedSpeciality,
              fullName: fullName));
        }
      }
      if (event is ProfileSetSpecialityPost) {
        var res = await ApiClient.post(
            'api/portfolio/myUniversity/kaz/setProfileSubject',
            {"subjectCode": selectedSubjectId});
        if (!res['success']) {
          emit(ProfileSetUniversitySubjectError());
        } else {
          emit(ProfileSetUniversitySubjectSuccess());
        }
        emit(ProfileLoaded(
            selectedForeignUniversities: selectedForeignUniversities,
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality,
            fullName: fullName));
      }
      if (event is ProfileSetUniSpecCode) {
        selectedUniSpecId = event.value;
      }
      if (event is ProfileSetSpeciality) {
        selectedSpeciality = event.value;
        selectedSubjectId = event.code;
        emit(ProfileLoaded(
            selectedForeignUniversities: selectedForeignUniversities,
            data: data,
            specialities: specialities['data']['subjects'],
            selectedSpeciality: selectedSpeciality,
            fullName: fullName));
      }

      if (event is ProfileAddKazUniversity) {
        var res = await ApiClient.post(
            'api/portfolio/myUniversity/kaz/setShortlistUniChoice', {
          "kazUniCode": event.kazUniCode,
          "kazSpecCode": selectedUniSpecId,
          "shortlistChoice": event.shortlistChoice
        });
        if (res['success']) {
          await BookmarkData().removeItem(
              AppHiveConstants.kzUniversities, event.shortlistChoice);
          await BookmarkData().addItem(AppHiveConstants.kzUniversities, {
            'id': event.shortlistChoice,
            'data': {
              'universityCode': event.kazUniCode,
              'name': event.titleJson,
              'type': event.shortlistChoice
            }
          });
          emit(ProfileLoaded(
              data: data,
              selectedForeignUniversities: selectedForeignUniversities,
              specialities: specialities['data']['subjects'],
              selectedSpeciality: selectedSpeciality,
              fullName: fullName));
        } else {
          emit(ProfileLoaded(
              data: data,
              selectedForeignUniversities: selectedForeignUniversities,
              specialities: specialities['data']['subjects'],
              selectedSpeciality: selectedSpeciality,
              fullName: fullName));
        }
      }
    });
  }
}
