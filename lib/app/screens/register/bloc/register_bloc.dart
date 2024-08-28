import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Timer? _timer;

  RegisterBloc() : super(RegisterInitial()) {
    bool isLoading = false;
    String shcoolCode = '';
    em() {
      emit(RegisterLoaded(isLoading: isLoading));
    }

    on<RegisterEvent>((event, emit) async {
      if (event is RegisterLoad) {
        emit(RegisterLoaded(isLoading: isLoading));
      }
      if (event is RegisterCheckClassCode) {
        var data = await ApiClient.getUnAuth(
            'api/auth/checkRegistrationCode/' + event.code);
        if (data['success']) {
          shcoolCode = event.code;
          emit(RegisterReturnRegisterPage());
        } else {
          emit(RegisterError(message: data['data']['message']));
        }
        em();
      }
      if (event is RegisterRegister) {
        isLoading = true;
        em();
        var data = await ApiClient.postUnAuth('api/auth/register', {
          'email': event.email,
          'password': event.password,
          'registrationCode': shcoolCode
        });
        if (data['success']) {
          isLoading = false;
          await LocalUtils.setToken(data['data']['accessToken']);
          emit(RegisterReturnVerifyPage());
          em();
        } else {
          isLoading = false;
          emit(RegisterError(message: data['data']['message']));
          em();
        }
      }
      if (event is RegisterResendEmailVerification) {
        var data = await ApiClient.post('api/auth/sendVerificationEmail', {});
        log(data.toString());
      }
      if (event is RegisterCheckVerifyEmail) {
        var req = await ApiClient.get('api/auth/checkVerificationStatus');
        if (req['success']) {
          emit(RegisterVerifySuccess());
          em();
        } else {
          emit(RegisterError(message: req['data']['message']));
          em();
        }
      }
      if (event is RegisterFillUserInfo) {
        isLoading = true;
        em();
        var req = await ApiClient.post('api/user/updateUserProfile', {
          "firstName": event.name,
          "lastName": event.surname,
          "sex": "none",
          "phoneNumber": event.phone,
          "parentPhoneNumbers": ["string"]
        });
        if (req['success']) {
          emit(RegisterSuccess());
          isLoading = false;
          em();
        }
      }
    });
  }
}
