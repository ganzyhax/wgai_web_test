part of 'specialities_bloc.dart';

@immutable
sealed class SpecialitiesEvent {}

class LoadSpecialities extends SpecialitiesEvent {}

final class LoadSpecialityById extends SpecialitiesEvent {
  final String id;
  LoadSpecialityById({required this.id});
}
