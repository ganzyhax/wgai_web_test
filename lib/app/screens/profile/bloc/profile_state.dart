part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final data;
  final specialities;
  final selectedSpeciality;
  final String fullName;
  ProfileLoaded(
      {required this.data,
      required this.specialities,
      required this.selectedSpeciality,
      required this.fullName});
}

final class ProfileUpdatedSuccess extends ProfileState {}

final class ProfileUpdateCareerError extends ProfileState {}
