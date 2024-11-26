part of 'colleges_bloc.dart';

@immutable
sealed class CollegesState {}

final class CollegesInitial extends CollegesState {}

final class CollegesLoaded extends CollegesState {
  final colleges;
  final filteredColleges;
  final specialities;
  CollegesLoaded(
      {required this.colleges,
      required this.specialities,
      required this.filteredColleges});
}
