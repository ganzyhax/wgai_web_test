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
    Future<void> _checkGuidanceTask(
        PersonalCheckGuidanceTask event, Emitter<PersonalState> emit) async {
      localLang = await LocalUtils.getLanguage();

      // Poll every 2 seconds to check if the test is complete
      const pollingInterval = Duration(seconds: 2);
      const maxRetries = 5; // Maximum retries
      int retryCount = 0;
      bool isResultReady = false;

      while (!isResultReady && retryCount < maxRetries) {
        log('Checking answer of Guidance task id ' +
            event.guidanceTaskId.toString());
        retryCount++;

        var req = await ApiClient.post(
            'api/guidanceTasks/' + event.guidanceTaskId, {});

        if (req['success']) {
          if (req['data']['task'].containsKey('result')) {
            if (req['data']['task']['result']
                .containsKey('interpretationLink')) {
              // Update the guidance task data in the local state
              for (var i = 0; i < data['data']['guidanceTasks'].length; i++) {
                if (data['data']['guidanceTasks'][i]['_id'] ==
                    event.guidanceTaskId) {
                  data['data']['guidanceTasks'][i] = req['data']['task'];
                }
              }

              // Emit the updated state
              emit(PersonalLoaded(
                  data: data['data']['guidanceTasks'], localLang: localLang));
              isResultReady = true;
            }
          } else {
            log('Result not ready yet, retrying...');
          }
        } else {
          log('Error checking guidance task');
        }

        // If the result is not ready and we haven't hit the retry limit, wait for the next poll
        if (!isResultReady && retryCount < maxRetries) {
          await Future.delayed(pollingInterval);
        }
      }

      // If the result wasn't ready after the retries, handle the failure
      if (!isResultReady) {
        log('Max retries reached. Result is still not ready.');
        // You can emit an error state here if needed
      }
    }

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
      if (event is PersonalCheckGuidanceTask) {
        await _checkGuidanceTask(event, emit);
      }
    });
  }
}
