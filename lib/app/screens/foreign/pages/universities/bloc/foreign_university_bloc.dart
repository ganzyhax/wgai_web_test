import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'foreign_university_event.dart';
part 'foreign_university_state.dart';

class ForeignUniversityBloc
    extends Bloc<ForeignUniversityEvent, ForeignUniversityState> {
  List<dynamic> _universityData = []; // Global list for storing universities

  ForeignUniversityBloc() : super(ForeignUniversityInitial()) {
    on<ForeignUniversityLoad>((event, emit) async {
      // Prepare query parameters
      final queryParams = {
        'feeStartRange': event.feeStartRange?.toString(),
        'feeEndRange': event.feeEndRange?.toString(),
        'countryCode': event.countryCode,
        'page': event.page.toString(),
        'limit': event.limit.toString(),
      }..removeWhere((key, value) => value == null);

      final queryString = Uri(queryParameters: queryParams).query;

      try {
        // API call to fetch universities
        final data = await ApiClient.get(
            'api/resources/foreign/universities?$queryString');

        if (data['success']) {
          // Check data structure before accessing
          if (data['data'] is Map && data['data']['data'] is List) {
            List<dynamic> newUniversities = data['data']['data'];
            int totalPages = data['data']['totalPages'] ?? 1;

            // Reset data if page is 1
            if (event.page == 1) {
              _universityData = [];
            }

            // Append new universities to the global list
            _universityData.addAll(newUniversities);

            // Emit updated state with appended data and total pages
            emit(ForeignUniversityLoaded(
              data: _universityData, // Global list of universities
              currentCountryCode: event.countryCode,
              currentPage: event.page ?? 1, // Current page
              totalPages: totalPages, // Total pages from the API response
            ));
          } else {
            log('Unexpected data format: ${data['data']}');
          }
        }
      } catch (error) {
        log('Error loading universities: $error');
      }
    });
  }
}
