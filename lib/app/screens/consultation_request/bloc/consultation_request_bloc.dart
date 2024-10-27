import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/consultation_request/widgets/time_slot_widget.dart';
import 'package:wg_app/app/screens/consultation_request/network/consultation_request_network.dart';
import 'package:wg_app/app/screens/consultation_request/model/slot_model.dart';

part 'consultation_request_event.dart';
part 'consultation_request_state.dart';

class ConsultationRequestBloc extends Bloc<ConsultationRequestEvent, ConsultationRequestState> {
  final ConsultationRequestNetwork _network = ConsultationRequestNetwork();

  ConsultationRequestBloc() : super(ConsultationRequestInitial()) {
    on<FetchSlots>(_onFetchSlots);
    on<SelectSlot>(_onSelectSlot);
    on<SubmitConsultationRequest>(_onSubmitConsultationRequest);
  }

  Future<void> _onFetchSlots(FetchSlots event, Emitter<ConsultationRequestState> emit) async {
    emit(ConsultationRequestLoading());
    try {
      final slots = await _network.getSlots(event.startDate, event.endDate);
      if (slots != null) {
        emit(ConsultationRequestLoaded(slots.data));
      } else {
        emit(ConsultationRequestError('Failed to fetch slots'));
      }
    } catch (e) {
      emit(ConsultationRequestError(e.toString()));
    }
  }

  void _onSelectSlot(SelectSlot event, Emitter<ConsultationRequestState> emit) {
    if (state is ConsultationRequestLoaded) {
      final currentState = state as ConsultationRequestLoaded;
      final updatedSlots = currentState.slots.map((slot) {
        return slot.id == event.slotId
            ? slot.copyWith(isSelected: true)
            : slot.copyWith(isSelected: false);
      }).toList();
      emit(ConsultationRequestLoaded(updatedSlots));
    }
  }

  Future<void> _onSubmitConsultationRequest(
    SubmitConsultationRequest event,
    Emitter<ConsultationRequestState> emit
  ) async {
    emit(ConsultationRequestLoading());
    try {
      // Assuming your network class has a method to submit the request
      final result = await _network.submitConsultationRequest("Консультация", event.selectedSlotId);
      if (result['success']) {
        emit(ConsultationRequestSubmitted("Consultation request submitted successfully"));
      } else {
        emit(ConsultationRequestError(result['message'] ?? "Failed to submit consultation request"));
      }
    } catch (e) {
      emit(ConsultationRequestError(e.toString()));
    }
  }

}