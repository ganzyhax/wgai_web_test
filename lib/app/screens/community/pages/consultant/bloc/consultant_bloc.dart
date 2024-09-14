import 'dart:developer';

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
    String localLang = 'ru';
    String userId;
    on<ConsultantEvent>((event, emit) async {
      if (event is ConsultantLoad) {
        print("Loading consultant screen");
        localLang = await LocalUtils.getLanguage();
        userId = await LocalUtils.getUserId();
        counselorData = await ApiClient.get('api/counselorTasks/');
        for (var counselor in counselorData['data']['counselorTasks']) {
          var getAuthor =
              await ApiClient.get('api/user/profile/' + counselor['author']);

          if (getAuthor['success']) {}
        }
        if (counselorData['success']) {
          emit(ConsultantLoaded(
            localLang: localLang,
            counselorData: counselorData['data']['counselorTasks'],
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
    });
  }
}
