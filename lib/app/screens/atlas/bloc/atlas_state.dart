part of 'atlas_bloc.dart';

@immutable
sealed class AtlasState {}

final class AtlasInitial extends AtlasState {}

final class AtlasLoading extends AtlasState {}

final class AtlasLoaded extends AtlasState {
  final List<Professions>? professions;

  AtlasLoaded(this.professions);
}

class SpecialitiesError extends AtlasState {
  final String message;

  SpecialitiesError(this.message);
}
