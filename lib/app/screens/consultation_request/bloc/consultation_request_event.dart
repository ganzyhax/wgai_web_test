part of 'consultation_request_bloc.dart';

@immutable
sealed class ConsultationRequestEvent {}

class FetchSlots extends ConsultationRequestEvent {
  final DateTime startDate;
  final DateTime endDate;

  FetchSlots(this.startDate, this.endDate);
}

class SelectSlot extends ConsultationRequestEvent {
  final String slotId;
  SelectSlot(this.slotId);
}

class SubmitConsultationRequest extends ConsultationRequestEvent {
  final String selectedSlotId;
  SubmitConsultationRequest(this.selectedSlotId);
}