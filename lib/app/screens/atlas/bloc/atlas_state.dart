part of 'atlas_bloc.dart';

@immutable
sealed class AtlasState {}

final class AtlasInitial extends AtlasState {}

final class AtlasLoading extends AtlasState {}

final class AtlasLoaded extends AtlasState {
  final professions;
  final clusters;
  AtlasLoaded({required this.professions, required this.clusters});
}

class SpecialitiesError extends AtlasState {
  final String message;

  SpecialitiesError(this.message);
}
