part of 'country_bloc.dart';

@immutable
sealed class CountryEvent {}

final class CountryLoad extends CountryEvent {}
