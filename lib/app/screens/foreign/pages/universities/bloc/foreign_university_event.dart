part of 'foreign_university_bloc.dart';

@immutable
abstract class ForeignUniversityEvent {}

class ForeignUniversityLoad extends ForeignUniversityEvent {
  final int? feeStartRange;
  final int? feeEndRange;
  final String? countryCode;
  final int? page; // Make nullable
  final int? limit; // Make nullable

  ForeignUniversityLoad({
    this.feeStartRange = 0,
    this.feeEndRange = 100000000,
    this.countryCode,
    this.page = 1, // Remove default value
    this.limit = 20, // Remove default value
  });
}
