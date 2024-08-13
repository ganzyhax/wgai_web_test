part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterCheckClassCode extends RegisterEvent {
  final String code;
  RegisterCheckClassCode({required this.code});
}

final class RegisterLoad extends RegisterEvent {}

final class RegisterRegister extends RegisterEvent {
  final String email;
  final String password;
  final String regCode;
  RegisterRegister(
      {required this.email, required this.password, required this.regCode});
}

final class RegisterStartVerifyTimer extends RegisterEvent {}

final class RegisterResendEmailVerification extends RegisterEvent {
  RegisterResendEmailVerification();
}

final class RegisterCheckVerifyEmail extends RegisterEvent {}

final class RegisterFillUserInfo extends RegisterEvent {
  final String name;
  final String surname;
  final String phone;
  RegisterFillUserInfo(
      {required this.name, required this.phone, required this.surname});
}
