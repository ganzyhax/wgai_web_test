part of 'colleges_bloc.dart';

@immutable
sealed class CollegesEvent {}

final class CollegesLoad extends CollegesEvent {}

final class CollegesLoadByFilters extends CollegesEvent {
  final String universityCode;
  final String? regionId;
  // final specialities;
  // final bool? hasDormitory;
  // final bool? hasMilitaryDept;

  CollegesLoadByFilters(
      {this.regionId,
      // this.specialities,
      // this.hasDormitory,
      // this.hasMilitaryDept,
      required this.universityCode});
}

final class CollegesResetFilter extends CollegesEvent {}

final class CollegesNextPage extends CollegesEvent {}
