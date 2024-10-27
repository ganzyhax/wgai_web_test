part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesEvent {}

class LoadUniversities extends UniversitiesEvent {}

class LoadSpecialtiesUni extends UniversitiesEvent {}

class LoadbyFilters extends UniversitiesEvent {
  final String universityCode;
  final String? regionId;
  final List<SpecialtiesUni>? specialities;
  final bool? hasDormitory;
  final bool? hasMilitaryDept;

  LoadbyFilters({this.regionId, this.specialities, this.hasDormitory, this.hasMilitaryDept, required this.universityCode});
}

class ResetFilters extends UniversitiesEvent {}
