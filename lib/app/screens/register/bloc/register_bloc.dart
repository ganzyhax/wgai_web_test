import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:http/http.dart' as http;

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
        var checkPhoneRes = await ApiClient.getUnAuth(
            'api/auth/checkRegisteredNumber/' + event.email);
        if (checkPhoneRes['success']) {
          if (checkPhoneRes['data']['alreadyRegistered']) {
            emit(RegisterError(message: 'Phone already registered!'));
            isLoading = false;
            em();
          } else {
            var data = await ApiClient.postUnAuth('api/auth/register', {
              'email': event.email.replaceAll('+7', '8'),
              'password': event.password,
              'registrationCode': shcoolCode
            });
            final random = Random();
            int randomNumber = 1000 + random.nextInt(9000);

            String phoneNumber = event.email.replaceAll('+', '');

            var sendMessage =
                await sendSmsCode(phoneNumber, randomNumber.toString());
            if (sendMessage['success']) {
              isLoading = false;
              // await LocalUtils.setAccessToken(data['data']['accessToken']);
              emit(RegisterReturnVerifyPage(pinCode: randomNumber.toString()));
              em();
            } else {
              isLoading = false;
              emit(RegisterError(message: 'error'));
              em();
            }
          }
        }
      }
      if (event is RegisterResendEmailVerification) {
        var data = await ApiClient.post('api/auth/sendVerificationEmail', {});
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
  sendSmsCode(phone, code) async {
    final url = Uri.parse(
        'https://api.mobizon.kz/service/message/sendsmsmessage?recipient=$phone&text=WeGlobal Ваш код - $code&apiKey=kzff7e39f70c4780fb84cf85e6ee93a92de9bbe56d2aa095bc2d12efca0c183315ff94');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Mobapp-Version': mbVer
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'data': jsonDecode(response.body)};
    }
  }
}
