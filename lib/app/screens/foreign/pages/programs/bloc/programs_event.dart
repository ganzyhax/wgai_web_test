part of 'programs_bloc.dart';

@immutable
sealed class ProgramsEvent {}

final class ProgramsLoad extends ProgramsEvent {}

final class ProgramsFilter extends ProgramsEvent {
  final String countryFilter;
  ProgramsFilter({required this.countryFilter});
}

final class ProgramsResetFilter extends ProgramsEvent {}
