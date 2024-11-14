import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:http/http.dart' as http;
part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    int type = 0;
    String otpSended = '';

    on<ForgetPasswordEvent>((event, emit) async {
      if (event is ForgetPasswordLoad) {
        emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
      }
      if (event is ForgetPasswordChangeType) {
        if (type == 0) {
          type = 1;
        } else {
          type = 0;
        }
        otpSended = '';
        emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
      }
      if (event is ForgetPasswordSendPhoneOTP) {
        String phone = event.phone;
        final random = Random();
        int randomNumber = 1000 + random.nextInt(9000);
        final url = Uri.parse(
            'https://api.mobizon.kz/service/message/sendsmsmessage?recipient=$phone&text=WeGlobal Ваш код - $randomNumber&apiKey=kzff7e39f70c4780fb84cf85e6ee93a92de9bbe56d2aa095bc2d12efca0c183315ff94');
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Mobapp-Version': mbVer
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          otpSended = randomNumber.toString();

          emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
        } else {}
      }
      if (event is ForgetPasswordSendEmailOTP) {
        var data = await ApiClient.post('api/auth/sendVerificationEmail', {});
        if (data['success']) {
          otpSended = '1';
          emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
        }
      }
      if (event is ForgetPasswordCheckEmailVerify) {
        var req = await ApiClient.get('api/auth/checkVerificationStatus');
        if (req['success']) {
          emit(ForgetPasswordSuccess());
          emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
        } else {
          emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
        }
      }
      if (event is ForgetPasswordChangeRegData) {
        otpSended = '';
        emit(ForgetPasswordLoaded(type: type, otpSended: otpSended));
      }
    });
  }
}
