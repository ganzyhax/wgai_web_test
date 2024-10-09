import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'ent_event.dart';
part 'ent_state.dart';

class EntBloc extends Bloc<EntEvent, EntState> {
  EntBloc() : super(EntInitial()) {
    var data;
    on<EntEvent>((event, emit) async {
      if (event is EntLoad) {
        data = await ApiClient.get('api/resources/UntContentMultiLang');

        if (data['success']) {}

        emit(EntLoaded(data: data));
      }
    });
  }
}
