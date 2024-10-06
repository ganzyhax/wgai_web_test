part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileLoad extends ProfileEvent {}

final class ProfileChangeUserData extends ProfileEvent {
  final String name;
  final String surname;
  ProfileChangeUserData({required this.name, required this.surname});
}
final class ProfileDeleteAccount extends ProfileEvent {}

final class ProfileSetSpeciality extends ProfileEvent {
  var value;
  String code;
  ProfileSetSpeciality({
    required this.value,
    required this.code,
  });
}

final class ProfileSetUniSpecCode extends ProfileEvent {
  final String value;
  ProfileSetUniSpecCode({required this.value});
}

final class ProfileSetSpecialityPost extends ProfileEvent {}

final class ProfileAddKazUniversity extends ProfileEvent {
  final String shortlistChoice;
  final titleJson;
  final String kazUniCode;

  ProfileAddKazUniversity(
      {required this.shortlistChoice,
      required this.kazUniCode,
      required this.titleJson});
}

final class ProfileSetKazUniversitySubject extends ProfileEvent {
  final String subjectCode;
  ProfileSetKazUniversitySubject({required this.subjectCode});
}

final class ProfileUniversitiesLoad extends ProfileEvent{
  
}
