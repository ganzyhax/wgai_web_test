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
    var authors;
    String localLang;
    String userId;
    on<ConsultantEvent>((event, emit) async {
      if (event is ConsultantLoad) {
        localLang = await LocalUtils.getLanguage();
        userId = await LocalUtils.getUserId();
        counselorData = await ApiClient.get('api/counselorTasks/');
        // for (var counselor in counselorData['data']['counselorTasks']) {
        //   log('Tring get ' + counselor['author']);
        //   var getAuthor =
        //       await ApiClient.get('api/user/profile/' + counselor['author']);

        //   log(getAuthor.toString());
        // }
        if (counselorData['success']) {
          emit(ConsultantLoaded(
            localLang: localLang,
            counselorData: counselorData['data']['counselorTasks'],
          ));
        }
      }
    });
  }
}
