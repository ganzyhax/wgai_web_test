part of 'foreign_university_bloc.dart';

@immutable
abstract class ForeignUniversityState {}

class ForeignUniversityInitial extends ForeignUniversityState {}

class ForeignUniversityLoaded extends ForeignUniversityState {
  final dynamic data; // Adjust the type according to your API response
  final String? currentCountryCode; // New property for country code
  final int currentPage; // New property for current page

  ForeignUniversityLoaded({
    required this.data,
    this.currentCountryCode,
    this.currentPage = 1, // Default to 1
  });
}
