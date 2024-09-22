part of 'specialities_bloc.dart';

@immutable
sealed class SpecialitiesState {}

final class SpecialitiesInitial extends SpecialitiesState {}

final class SpecialitiesLoading extends SpecialitiesState {}

final class SpecialitiesLoaded extends SpecialitiesState {
  final List<Specialties>? specialResources;
  final specialities;

  SpecialitiesLoaded(this.specialResources, this.specialities);
}

class SpecialitiesError extends SpecialitiesState {
  final String message;

  SpecialitiesError(this.message);
}
