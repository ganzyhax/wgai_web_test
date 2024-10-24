part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {
  final bool isLoading;
  LoginLoaded({required this.isLoading});
}

final class LoginSuccess extends LoginState {
  final bool mustChangePassword;
  LoginSuccess({required this.mustChangePassword});
}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
