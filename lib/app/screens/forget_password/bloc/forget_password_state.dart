part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoaded extends ForgetPasswordState {
  final int type;
  final String otpSended;
  ForgetPasswordLoaded({required this.type, required this.otpSended});
}

final class ForgetPasswordSuccess extends ForgetPasswordState {}

final class ForgetPasswordOpenChangePasswordPage extends ForgetPasswordState {}
