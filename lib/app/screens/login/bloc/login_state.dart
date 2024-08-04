part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {
  final bool isLoading;
  LoginLoaded({required this.isLoading});
}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {}
