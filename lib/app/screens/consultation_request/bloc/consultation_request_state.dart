part of 'consultation_request_bloc.dart';

@immutable
sealed class ConsultationRequestState {}

final class ConsultationRequestInitial extends ConsultationRequestState {}

class ConsultationRequestLoading extends ConsultationRequestState {}

class ConsultationRequestLoaded extends ConsultationRequestState {
  final List<SlotModel> slots;
  ConsultationRequestLoaded(this.slots);
}

class ConsultationRequestError extends ConsultationRequestState {
  final String message;

  ConsultationRequestError(this.message);

  @override
  List<Object> get props => [message];
}

class ConsultationRequestSubmitted extends ConsultationRequestState {
  final String message;

  ConsultationRequestSubmitted(this.message);

  @override
  List<Object> get props => [message];
}