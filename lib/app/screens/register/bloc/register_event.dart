part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterCheckClassCode extends RegisterEvent {
  final String code;
  RegisterCheckClassCode({required this.code});
}

final class RegisterLoad extends RegisterEvent {}
