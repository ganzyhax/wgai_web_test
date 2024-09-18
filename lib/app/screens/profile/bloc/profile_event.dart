part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileLoad extends ProfileEvent {}

final class ProfileChangeUserData extends ProfileEvent {
  final String name;
  final String surname;
  ProfileChangeUserData({required this.name, required this.surname});
}

final class ProfileSetSpeciality extends ProfileEvent {
  var value;
  String code;
  ProfileSetSpeciality({
    required this.value,
    required this.code,
  });
}

final class ProfileSetSpecialityPost extends ProfileEvent {}

final class ProfileAddKazUniversity extends ProfileEvent {
  final String shortlistChoice;
  final String kazSpecCode;
  final String kazUniCode;
  ProfileAddKazUniversity(
      {required this.shortlistChoice,
      required this.kazSpecCode,
      required this.kazUniCode});
}

final class ProfileSetKazUniversitySubject extends ProfileEvent {
  final String subjectCode;
  ProfileSetKazUniversitySubject({required this.subjectCode});
}

final class ProfileAddMyCareerBookmark extends ProfileEvent {
  final String occupationCode;
  var title;
  final String areaIconCode;
  ProfileAddMyCareerBookmark(
      {required this.occupationCode,
      required this.title,
      required this.areaIconCode});
}

final class ProfileDeleteMyCareerBookmark extends ProfileEvent {
  final String occupationCode;
  ProfileDeleteMyCareerBookmark({required this.occupationCode});
}
