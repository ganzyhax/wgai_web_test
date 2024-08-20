part of 'universities_bloc.dart';

@immutable
sealed class UniversitiesState {}

final class UniversitiesInitial extends UniversitiesState {}

final class UniversitiesLoading extends UniversitiesState {}

final class UniversitiesLoaded extends UniversitiesState {
  final List<University> universities;

  UniversitiesLoaded(this.universities);
}

class UniversitiesError extends UniversitiesState {
  final String message;

  UniversitiesError(this.message);
}
