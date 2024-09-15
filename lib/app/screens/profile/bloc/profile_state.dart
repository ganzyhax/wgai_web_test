part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final data;
  final specialities;
  final String selectedSpeciality;
  final String fullName;
  ProfileLoaded(
      {required this.data,
      required this.specialities,
      required this.selectedSpeciality,
      required this.fullName});
}

final class ProfileUpdatedSuccess extends ProfileState {}
