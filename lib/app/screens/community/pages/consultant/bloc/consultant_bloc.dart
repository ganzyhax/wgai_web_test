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
        localLang = await LocalUtils.getLanguage();
        userId = await LocalUtils.getUserId();
        counselorData = await ApiClient.get('api/counselorTasks/');
        if (counselorData['success']) {
          List<Future> authorInfoFutures = [];
          counselorData['data']['counselorTasks'].asMap().forEach((index, counselor) {
            var future = ApiClient.get('api/user/profile/' + counselor['authorId']).then((authorInfo) {
              if (authorInfo['success']) {
                final firstName = authorInfo['data']['user']?['firstName'] ?? "";
                final lastName = authorInfo['data']['user']?['lastName'] ?? "";
                counselorData['data']['counselorTasks'][index]["authorName"] = "$firstName $lastName";
              } else {
                counselorData['data']['counselorTasks'][index]["authorName"] = "";
              }
            });
            authorInfoFutures.add(future);
          });
          // Wait for all futures to complete
          await Future.wait(authorInfoFutures);

          // Sort the tasks by createdAt in descending order
          List<dynamic> tasks = counselorData['data']['counselorTasks'];
          sortTasksByCreatedAtDescending(tasks);

          // Now that all author info has been fetched, emit the event
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
