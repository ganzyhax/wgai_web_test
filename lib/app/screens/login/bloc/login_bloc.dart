import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/api/auth_utils.dart';
import 'package:wg_app/app/utils/amplitude.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/utils/fcm_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    bool isLoading = false;
    on<LoginEvent>((event, emit) async {
      if (event is LoginLoad) {
        emit(LoginLoaded(isLoading: isLoading));
      }
      if (event is LoginLog) {
        isLoading = true;
        emit(LoginLoaded(isLoading: isLoading));

        var attemp = await AuthUtils.login(event.login, event.password);

        if (attemp is bool) {
          try {
            String userId = await LocalUtils.getUserId();
            AmplitudeFunc().setUserProperties({'userId': userId});
            AmplitudeFunc().logEvent('Login', {});
            String token = await FCMService().getToken() ?? '';

            if (token != '') {
              var resp = await ApiClient.post(
                  'api/user/addFcmToken', {"fcmToken": token});

              if (resp['success']) {
                print('Token added successfully');
              }
            }
          } catch (e) {
            print('Token adding error: ' + e.toString());
          }
          await LocalUtils.setLogin(event.login);
          await LocalUtils.setPassword(event.password);
          // if (event.password == event.login) {
          //   emit(LoginSuccess(mustChangePassword: true));
          // } else {
          //   emit(LoginSuccess(mustChangePassword: false));
          // }
          emit(LoginSuccess(mustChangePassword: false));
          isLoading = false;
        } else {
          emit(LoginError(message: attemp));
        }
        isLoading = false;

        emit(LoginLoaded(isLoading: isLoading));
      }
    });
  }
}
