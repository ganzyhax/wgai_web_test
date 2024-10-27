part of 'profile_career_bloc.dart';

@immutable
sealed class ProfileCareerEvent {}

final class ProfileCareerLoad extends ProfileCareerEvent {}

final class ProfileAddCareer extends ProfileCareerEvent {
  final String occupationCode;
  var title;
  final String areaIconCode;
  ProfileAddCareer(
      {required this.occupationCode,
      required this.title,
      required this.areaIconCode});
}

final class ProfileDeleteCareer extends ProfileCareerEvent {
  final String occupationCode;
  ProfileDeleteCareer({required this.occupationCode});
}
