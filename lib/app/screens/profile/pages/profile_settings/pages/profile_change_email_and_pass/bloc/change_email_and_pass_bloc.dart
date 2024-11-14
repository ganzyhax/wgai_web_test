import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:http/http.dart' as http;

part 'change_email_and_pass_event.dart';
part 'change_email_and_pass_state.dart';

class ChangeEmailAndPassBloc
    extends Bloc<ChangeEmailAndPassEvent, ChangeEmailAndPassState> {
  ChangeEmailAndPassBloc() : super(ChangeEmailAndPassInitial()) {
    String otp = '';
    bool emailNeeds = false;
    bool phoneNeeds = false;
    int type = 0;

    on<ChangeEmailAndPassEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ChangeEmailAndPassLoad) {
        String userId = await LocalUtils.getUserId();
        var reqProfile = await ApiClient.get('api/user/profile/' + userId);

        String login = await LocalUtils.getLogin();
        String pass = await LocalUtils.getPassword();

        if (login == pass) {
          emailNeeds = true;
          phoneNeeds = true;
        }
        emailNeeds = true;
        phoneNeeds = true;
        emit(ChangeEmailAndPassLoaded(
            emailNeeds: emailNeeds,
            phoneNeeds: phoneNeeds,
            type: type,
            otp: otp));
      }
      if (event is ChangeEmailAndPassChangePhone) {
        var req = await ApiClient.post(
            'api/user/updateUserProfile', {'phone': event.phone});
        if (req['success']) {
          await LocalUtils.setLogin(event.phone);

          emailNeeds = false;
          emit(ChangeEmailAndPassLoaded(
              emailNeeds: emailNeeds,
              phoneNeeds: phoneNeeds,
              type: type,
              otp: otp));
          if (phoneNeeds == false) {
            emit(ChangeEmailAndPassSuccess());
          }
        }
      }
      if (event is ChangeEmailAndPassChangePass) {
        var req = await ApiClient.put(
            'api/user/updatePassword', {'newPassword': event.pass});
        if (req['success']) {
          phoneNeeds = false;
          await LocalUtils.setPassword(event.pass);
          emit(ChangeEmailAndPassLoaded(
              emailNeeds: emailNeeds,
              phoneNeeds: phoneNeeds,
              type: type,
              otp: otp));
          if (emailNeeds == false) {
            emit(ChangeEmailAndPassSuccess());
          }
        }
      }
      if (event is ChangeEmailAndPassClose) {
        emit(ChangeEmailAndPassSuccess());
      }
      if (event is ChangeEnailAndPassSetOtherPhone) {
        otp = '';
        phoneNeeds = true;
        emit(ChangeEmailAndPassLoaded(
            emailNeeds: emailNeeds,
            phoneNeeds: phoneNeeds,
            type: type,
            otp: otp));
      }
      if (event is ChangeEmailAndPassSendOTP) {
        final random = Random();

        int randomNumber = 1000 + random.nextInt(9000);
        var mobizonRes =
            await sendSmsCode(event.phone, randomNumber.toString());
        if (mobizonRes['success']) {
          otp = randomNumber.toString();
          emit(ChangeEmailAndPassLoaded(
              emailNeeds: emailNeeds,
              phoneNeeds: phoneNeeds,
              type: type,
              otp: otp));
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
