part of 'programs_bloc.dart';

@immutable
sealed class ProgramsState {}

final class ProgramsInitial extends ProgramsState {}

final class ProgramsLoaded extends ProgramsState {
  final data;
  ProgramsLoaded({required this.data});
}
