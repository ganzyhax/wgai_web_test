part of 'change_email_and_pass_bloc.dart';

@immutable
sealed class ChangeEmailAndPassState {}

final class ChangeEmailAndPassInitial extends ChangeEmailAndPassState {}

final class ChangeEmailAndPassLoaded extends ChangeEmailAndPassState {
  final int type;
  final bool phoneNeeds;
  final bool emailNeeds;
  final String otp;
  ChangeEmailAndPassLoaded(
      {required this.emailNeeds,
      required this.phoneNeeds,
      required this.type,
      required this.otp});
}

final class ChangeEmailAndPassSuccess extends ChangeEmailAndPassState {}

final class ChangeEmailAndPassPhoneSuccess extends ChangeEmailAndPassState {}

final class ChangeEmailAndPassPassSuccess extends ChangeEmailAndPassState {}
