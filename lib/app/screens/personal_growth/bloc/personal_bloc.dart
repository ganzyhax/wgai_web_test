import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial()) {
    var data;
    on<PersonalEvent>((event, emit) async {
      if (event is PersonalLoad) {
        data = await ApiClient.get('api/guidanceTasks/');
        if (data['success']) {
          emit(PersonalLoaded(data: data['data']['guidanceTasks']));
        } else {
          emit(PersonalLoaded(data: data));
        }
      }
    });
  }
}
