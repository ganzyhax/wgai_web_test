part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesEvent {}

class LoadUniversities extends UniversitiesEvent {}

class LoadbyFilters extends UniversitiesEvent {
  final String regionId;
  final List<Specialties>? specialities;
  final bool? hasDormitory;
  final bool? hasMilitaryDept;

  LoadbyFilters(
      {required this.regionId,
      this.specialities,
      this.hasDormitory,
      this.hasMilitaryDept});
}

class ResetFilters extends UniversitiesEvent {}
