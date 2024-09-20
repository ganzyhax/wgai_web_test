part of 'profile_career_bloc.dart';

@immutable
sealed class ProfileCareerState {}

final class ProfileCareerInitial extends ProfileCareerState {}

final class ProfileCareerLoaded extends ProfileCareerState {
  final myCareers;
  final recCareers;
  ProfileCareerLoaded({required this.myCareers, required this.recCareers});
}
