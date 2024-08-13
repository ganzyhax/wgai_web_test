import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterLoad) {}
      if (event is RegisterCheckClassCode) {
        var data = await ApiClient.get('checkRegistrationCode/' + event.code);
        log(data.toString());
      }
    });
  }
}
