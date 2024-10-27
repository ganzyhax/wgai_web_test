part of 'ent_bloc.dart';

@immutable
sealed class EntState {}

final class EntInitial extends EntState {}

final class EntLoaded extends EntState {
  final data;
  EntLoaded({required this.data});
}
