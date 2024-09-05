part of 'profile_growth_bloc.dart';

@immutable
sealed class ProfileGrowthState {}

final class ProfileGrowthInitial extends ProfileGrowthState {}

final class ProfileGrowthLoaded extends ProfileGrowthState {
  final data;
  ProfileGrowthLoaded({required this.data});
}

final class ProfileGrowthError extends ProfileGrowthState {
  final String errorText;
  ProfileGrowthError({required this.errorText});
}
