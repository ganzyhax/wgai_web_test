part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

final class ForgetPasswordLoad extends ForgetPasswordEvent {}

final class ForgetPasswordChangeType extends ForgetPasswordEvent {}

final class ForgetPasswordSendEmailOTP extends ForgetPasswordEvent {
  final String email;
  ForgetPasswordSendEmailOTP({required this.email});
}

final class ForgetPasswordSendPhoneOTP extends ForgetPasswordEvent {
  final String phone;
  ForgetPasswordSendPhoneOTP({required this.phone});
}

final class ForgetPasswordCheckEmailVerify extends ForgetPasswordEvent {}

final class ForgetPasswordChangeRegData extends ForgetPasswordEvent {}

final class ForgetPasswordChangePass extends ForgetPasswordEvent {}
