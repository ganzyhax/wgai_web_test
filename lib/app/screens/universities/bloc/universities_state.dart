part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesState {}

final class UniversitiesInitial extends UniversitiesState {}

final class UniversitiesLoading extends UniversitiesState {}

final class UniversitiesLoaded extends UniversitiesState {
  final List<Universities>? universities;

  UniversitiesLoaded(this.universities);
}

class FiltersApplied extends UniversitiesState {
  final String? regionId;
  final List<Specialties>? specialities;
  final bool? hasDormitory;
  final bool? hasMilitaryDept;

  FiltersApplied({
    this.regionId,
    this.specialities,
    this.hasDormitory,
    this.hasMilitaryDept,
  });
}

class UniversitiesError extends UniversitiesState {
  final String message;

  UniversitiesError(this.message);
}
