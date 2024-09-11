part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final data;
  final specialities;
  final String selectedSpeciality;
  ProfileLoaded(
      {required this.data,
      required this.specialities,
      required this.selectedSpeciality});
}

final class ProfileUpdatedSuccess extends ProfileState {}
