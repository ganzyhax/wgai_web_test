part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoaded extends RegisterState {
  final bool isLoading;
  RegisterLoaded({required this.isLoading});
}

final class RegisterReturnRegisterPage extends RegisterState {}

final class RegisterReturnVerifyPage extends RegisterState {
  final String pinCode;
  RegisterReturnVerifyPage({required this.pinCode});
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError({required this.message});
}

final class RegisterVerifySuccess extends RegisterState {}

final class RegisterSuccess extends RegisterState {}
