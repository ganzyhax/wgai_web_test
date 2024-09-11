part of 'personal_bloc.dart';

@immutable
sealed class PersonalEvent {}

final class PersonalLoad extends PersonalEvent {}

final class PersonalChangeLang extends PersonalEvent {
  final String value;
  PersonalChangeLang({required this.value});
}
