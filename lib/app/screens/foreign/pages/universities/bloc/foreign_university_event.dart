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
    this.feeStartRange,
    this.feeEndRange,
    this.countryCode,
    this.page, // Remove default value
    this.limit, // Remove default value
  });
}
