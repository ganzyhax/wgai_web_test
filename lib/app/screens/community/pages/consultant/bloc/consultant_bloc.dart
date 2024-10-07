import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';

part 'consultant_event.dart';
part 'consultant_state.dart';

class ConsultantBloc extends Bloc<ConsultantEvent, ConsultantState> {
  ConsultantBloc() : super(ConsultantInitial()) {
    var counselorData;
    var authors = [];
    var appointmentData;
    String localLang = 'ru';
    String userId;
    Future<void> _checkCounselorTask(
        ConsultantCheckTask event, Emitter<ConsultantState> emit) async {
      String localLang = await LocalUtils.getLanguage();
      const pollingInterval = Duration(seconds: 2);
      const maxRetries = 5; // Maximum retries
      int retryCount = 0;
      bool isResultReady = false;

      while (!isResultReady && retryCount < maxRetries) {
        log('Checking status of Counselor task id ' + event.taskId.toString());
        retryCount++;

        var req = await ApiClient.get('api/counselorTasks/' + event.taskId);

        if (req['success']) {
          if (req['data']['task'].containsKey('result')) {
            if (req['data']['task']['result']
                .containsKey('interpretationLink')) {
              for (var i = 0;
                  i < counselorData['data']['counselorTasks'].length;
                  i++) {
                if (counselorData['data']['counselorTasks'][i]['_id'] ==
                    event.taskId) {
                  counselorData['data']['counselorTasks'][i] =
                      req['data']['task'];
                }
              }
              emit(ConsultantLoaded(
                localLang: localLang,
                counselorData: counselorData['data']['counselorTasks'],
                appointmentData: appointmentData
              ));
              isResultReady = true;
            }
          } else {
            log('Result not ready yet, retrying...');
          }
        } else {
          log('Error checking counselor task');
        }

        if (!isResultReady && retryCount < maxRetries) {
          await Future.delayed(pollingInterval);
        }
      }

      if (!isResultReady) {
        log('Max retries reached, counselor task result is still not ready');
      }
    }

    on<ConsultantEvent>((event, emit) async {
      if (event is ConsultantLoad) {
        localLang = await LocalUtils.getLanguage();
        userId = await LocalUtils.getUserId();
        counselorData = await ApiClient.get('api/counselorTasks/');
        if (counselorData['success']) {
          List<dynamic> tasks = counselorData['data']['counselorTasks'];
          sortTasksByCreatedAtDescending(tasks);
          var appointmentDataReq = await ApiClient.get('api/slots/upcomingAppointment');
          emit(ConsultantLoaded(
            localLang: localLang,
            counselorData: counselorData['data']['counselorTasks'],
            appointmentData: appointmentDataReq['data']['data']
          ));
        }
      }
      if (event is ConsultantUpdateStatus) {
        var req = await ApiClient.post('api/counselorTasks/updateStatus',
            {"taskId": event.taskId, "newStatus": event.status});
        if (req['success']) {
          add(ConsultantLoad());
        }
      }
      if (event is ConsultantOptionSubmitResponse) {
        var req = await ApiClient.post('api/counselorTasks/submitResponse', {
          "taskId": event.taskId,
          "taskResponse": (event.answer.length == 0) ? [] : [event.answer]
        });
        if (req['success']) {
          if (event.answer.length == 0) {
            add(ConsultantUpdateStatus(
                taskId: event.taskId, status: 'incomplete'));
          } else {
            add(ConsultantUpdateStatus(
                taskId: event.taskId, status: 'complete'));
          }
          add(ConsultantLoad());
        }
      }
      if (event is ConsultantTextBoxSubmitResponse) {
        var req = await ApiClient.post('api/counselorTasks/submitResponse',
            {"taskId": event.taskId, "taskResponse": event.answer});
        if (req['success']) {
          if (event.answer == 'none') {
            add(ConsultantUpdateStatus(
                taskId: event.taskId, status: 'incomplete'));
          } else {
            add(ConsultantUpdateStatus(
                taskId: event.taskId, status: 'complete'));
          }
          add(ConsultantLoad());
        }
      }
      if (event is ConsultantCheckTask) {
        await _checkCounselorTask(event, emit);
      }
    });
  }
  void sortTasksByCreatedAtDescending(List<dynamic> tasks) {
    tasks.sort((a, b) {
      // Parse the createdAt string to DateTime objects
      DateTime dateA = DateTime.parse(a['createdAt']);
      DateTime dateB = DateTime.parse(b['createdAt']);

      // Compare dates for descending order
      return dateB.compareTo(dateA);
    });
  }
}
