part of 'consultant_bloc.dart';

@immutable
sealed class ConsultantState {}

final class ConsultantInitial extends ConsultantState {}

final class ConsultantLoaded extends ConsultantState {
  final counselorData;
  final String localLang;
  ConsultantLoaded({required this.counselorData, required this.localLang});
}