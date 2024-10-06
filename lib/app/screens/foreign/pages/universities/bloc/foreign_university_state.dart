part of 'foreign_university_bloc.dart';

@immutable
abstract class ForeignUniversityState {}

class ForeignUniversityInitial extends ForeignUniversityState {}

class ForeignUniversityLoaded extends ForeignUniversityState {
  final List<dynamic> data;
  final String? currentCountryCode;
  final int currentPage;
  final int totalPages;
  final int? feeStartRange;
  final int? feeEndRange;

  ForeignUniversityLoaded({
    required this.data,
    this.currentCountryCode,
    required this.currentPage,
    required this.totalPages,
    this.feeStartRange,
    this.feeEndRange,
  });
}
