import 'dart:developer';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/consultation_request/model/slot_model.dart';

class ConsultationRequestNetwork {
  Future<SlotResponse?> getSlots(DateTime startDate, DateTime endDate) async {
    final formattedStartDate = startDate.toIso8601String();
    final formattedEndDate = endDate.toIso8601String();
    
    final response = await ApiClient.get('api/slots?startDate=$formattedStartDate&endDate=$formattedEndDate');
    
    if (response['success']) {
      try {
        final slotResponse = SlotResponse.fromJson(response['data']);
        return slotResponse;
      } catch (e) {
        log('Error parsing slot data: $e');
        return null;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> submitConsultationRequest(String title, String slotId) async {
    try {
      final response = await ApiClient.post('api/slots/book', {'title': title, 'slotId': slotId});

      if (response['success']) {
        return {
          'success': true,
          'message': response['data']['message'] ?? 'Slot booked successfully',
        };
      } else {
        return {
          'success': false,
          'message': response['data']['message'] ?? 'Failed to book slot',
        };
      }
    } catch (e) {
      log('Error booking appointment: $e');
      return {
        'success': false,
        'message': 'An error occurred while booking the appointment',
      };
    }
  }
}