part of 'change_email_and_pass_bloc.dart';

@immutable
sealed class ChangeEmailAndPassEvent {}

final class ChangeEmailAndPassLoad extends ChangeEmailAndPassEvent {}

final class ChangeEmailAndPassChangePhone extends ChangeEmailAndPassEvent {
  final String phone;
  ChangeEmailAndPassChangePhone({required this.phone});
}

final class ChangeEmailAndPassChangePass extends ChangeEmailAndPassEvent {
  final String pass;
  ChangeEmailAndPassChangePass({required this.pass});
}

final class ChangeEmailAndPassClose extends ChangeEmailAndPassEvent {}

final class ChangeEmailAndPassSendOTP extends ChangeEmailAndPassEvent {
  final String phone;
  ChangeEmailAndPassSendOTP({required this.phone});
}
