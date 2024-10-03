part of 'country_bloc.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class CountryLoaded extends CountryState {
  final data;
  CountryLoaded({required this.data});
}
