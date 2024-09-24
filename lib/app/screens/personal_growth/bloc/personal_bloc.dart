import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial()) {
    var data;
    String localLang;
    on<PersonalEvent>((event, emit) async {
      if (event is PersonalLoad) {
        localLang = await LocalUtils.getLanguage();
        data = await ApiClient.get('api/guidanceTasks/');
        if (data['success']) {
          emit(PersonalLoaded(
              data: data['data']['guidanceTasks'], localLang: localLang));
        } else {
          emit(PersonalLoaded(data: data, localLang: localLang));
        }
      }
      if (event is PersonalChangeLang) {
        localLang = event.value;
        emit(PersonalLoaded(
            data: data['data']['guidanceTasks'], localLang: localLang));
      }
      if (event is PersonalGuidanceTaskUpdateStatus) {
        var req = await ApiClient.post('api/guidanceTasks/updateStatus',
            {"taskId": event.guidanceTaskId, "newStatus": event.status});
        if (req['success']) {
          add(PersonalLoad());
        } else {
          log('Error update guidance task');
        }
      }
    });
  }
}
