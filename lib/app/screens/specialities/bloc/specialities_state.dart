part of 'specialities_bloc.dart';

@immutable
sealed class SpecialitiesState {}

final class SpecialitiesInitial extends SpecialitiesState {}

final class SpecialitiesLoading extends SpecialitiesState {}

final class SpecialitiesLoaded extends SpecialitiesState {
  final List<SpecialResources> specialResources;

  SpecialitiesLoaded(this.specialResources);
}

class SpecialitiesError extends SpecialitiesState {
  final String message;

  SpecialitiesError(this.message);
}
