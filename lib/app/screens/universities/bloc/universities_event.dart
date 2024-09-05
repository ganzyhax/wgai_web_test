part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesEvent {}

class LoadUniversities extends UniversitiesEvent {}

class LoadCities extends UniversitiesEvent {
  final String regionId;
  final List<Specialties>? specialities;
  final bool hasDormitory;
  final bool hasMilitaryDept;

  LoadCities(
      {required this.regionId,
      required this.specialities,
      required this.hasDormitory,
      required this.hasMilitaryDept});
}

class ResetFilters extends UniversitiesEvent {}
