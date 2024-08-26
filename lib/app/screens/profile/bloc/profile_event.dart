part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileLoad extends ProfileEvent {}

final class ProfileChangeUserData extends ProfileEvent {
  final String name;
  final String surname;
  ProfileChangeUserData({required this.name, required this.surname});
}
