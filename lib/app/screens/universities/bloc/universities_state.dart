part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesState {}

final class UniversitiesInitial extends UniversitiesState {}

final class UniversitiesLoading extends UniversitiesState {}

final class UniversitiesLoaded extends UniversitiesState {
  final List<Universities>? universities;
  final List<Universities>? filteredUniversities;

  UniversitiesLoaded(
      {required this.universities, required this.filteredUniversities});
}

class FiltersApplied extends UniversitiesState {
  final String? regionId;
  final List<SpecialtiesUni>? specialities;
  final bool? hasDormitory;
  final bool? hasMilitaryDept;

  FiltersApplied({
    this.regionId,
    this.specialities,
    this.hasDormitory,
    this.hasMilitaryDept,
  });
}

class SpecialitesInUni extends UniversitiesState {
  final List<Specialties>? specialities;

  SpecialitesInUni(this.specialities);
}

class UniversitiesError extends UniversitiesState {
  final String message;

  UniversitiesError(this.message);
}
