part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoaded extends ForgetPasswordState {
  final int type;
  final bool otpSended;
  ForgetPasswordLoaded({required this.type, required this.otpSended});
}
