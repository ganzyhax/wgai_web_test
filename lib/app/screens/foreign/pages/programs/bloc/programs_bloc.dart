import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  ProgramsBloc() : super(ProgramsInitial()) {
    var data;
    var sortedDatas = [];
    String filterCountry = '';
    on<ProgramsEvent>((event, emit) async {
      if (event is ProgramsLoad) {
        data = await ApiClient.get('api/resources/foreign/programs');
        if (data['success']) {
          sortedDatas = data['data']['data'];
          emit(ProgramsLoaded(data: sortedDatas));
        }
      }
      if (event is ProgramsFilter) {
        filterCountry = event.countryFilter;
        sortedDatas = [];
        for (var i = 0; i < data['data']['data'].length; i++) {
          if (data['data']['data'][i]['countryCode'] == filterCountry) {
            sortedDatas.add(data['data']['data'][i]);
          }
        }

        emit(ProgramsLoaded(data: sortedDatas));
      }
      if (event is ProgramsResetFilter) {
        sortedDatas = data['data']['data'];
        emit(ProgramsLoaded(data: sortedDatas));
      }
    });
  }
}
