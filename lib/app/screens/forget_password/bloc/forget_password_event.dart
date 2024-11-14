part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

final class ForgetPasswordLoad extends ForgetPasswordEvent {}

final class ForgetPasswordChangeType extends ForgetPasswordEvent {}

final class ForgetPasswordSendSms extends ForgetPasswordEvent {
  String phone;
  ForgetPasswordSendSms({required this.phone});
}
