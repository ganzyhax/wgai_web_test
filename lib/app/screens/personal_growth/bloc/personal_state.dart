part of 'personal_bloc.dart';

@immutable
sealed class PersonalState {}

final class PersonalInitial extends PersonalState {}

final class PersonalLoaded extends PersonalState {
  final data;
  PersonalLoaded({required this.data});
}
