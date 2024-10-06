part of 'programs_bloc.dart';

@immutable
sealed class ProgramsEvent {}

final class ProgramsLoad extends ProgramsEvent {}
