part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final data;
  final specialities;
  final selectedSpeciality;
  final String fullName;
  final selectedForeignUniversities;
  ProfileLoaded(
      {required this.data,
      required this.specialities,
      required this.selectedForeignUniversities,
      required this.selectedSpeciality,
      required this.fullName});
}

final class ProfileUpdatedSuccess extends ProfileState {}

final class ProfileUpdateCareerError extends ProfileState {}

final class ProfileSetUniversitySubjectError extends ProfileState {}

final class ProfileSetUniversitySubjectSuccess extends ProfileState {}

final class ProfileLoading extends ProfileState{}