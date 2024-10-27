import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_hive_constants.dart';

part 'profile_career_event.dart';
part 'profile_career_state.dart';

class ProfileCareerBloc extends Bloc<ProfileCareerEvent, ProfileCareerState> {
  ProfileCareerBloc() : super(ProfileCareerInitial()) {
    var myCareers;
    var recCareers;
    on<ProfileCareerEvent>((event, emit) async {
      if (event is ProfileCareerLoad) {
        var data = await ApiClient.get('api/portfolio/myCareer');

        if (data['success']) {
          myCareers = data['data']['myCareer']['bookmarkedProfessions'];
          recCareers = data['data']['myCareer']['recommendedProfessions'];
          List<dynamic> transformedData = myCareers.map((item) {
            return {
              'id': item['code'], // Set 'id' as the 'code'
              'data': item // Put the entire original item under 'data'
            };
          }).toList();
          await BookmarkData()
              .loadData(AppHiveConstants.professions, transformedData);
        }

        emit(ProfileCareerLoaded(myCareers: myCareers, recCareers: recCareers));
      }
      if (event is ProfileAddCareer) {
        var res = await ApiClient.post('api/portfolio/myCareer/addBookmark',
            {'occupationCode': event.occupationCode});

        if (res['success']) {
          await BookmarkData().addItem(AppHiveConstants.professions, {
            'id': event.occupationCode,
            'data': {'name': event.title, 'areaIconCode': event.areaIconCode}
          });
        } else {
          log('errore adding bookmark ');
        }
        emit(ProfileCareerLoaded(myCareers: myCareers, recCareers: recCareers));
      }
      if (event is ProfileDeleteCareer) {
        var res = await ApiClient.post('api/portfolio/myCareer/removeBookmark',
            {'occupationCode': event.occupationCode});

        if (res['success']) {
          await BookmarkData()
              .removeItem(AppHiveConstants.professions, event.occupationCode);
          emit(ProfileCareerLoaded(
              myCareers: myCareers, recCareers: recCareers));
        } else {
          emit(ProfileCareerLoaded(
              myCareers: myCareers, recCareers: recCareers));
        }
      }
    });
  }
}
