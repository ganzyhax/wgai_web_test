import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitial()) {
    var data;
    on<CountryEvent>((event, emit) async {
      if (event is CountryLoad) {
        data = await ApiClient.get('api/resources/foreign/countries');
        if (data['success']) {
          emit(CountryLoaded(data: data['data']));
        }
      }
    });
  }
}
