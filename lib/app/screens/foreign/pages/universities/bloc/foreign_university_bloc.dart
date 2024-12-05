import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'foreign_university_event.dart';
part 'foreign_university_state.dart';

class ForeignUniversityBloc
    extends Bloc<ForeignUniversityEvent, ForeignUniversityState> {
  List<dynamic> _universityData = []; // Global list for storing universities

  int? _feeStartRange;
  int? _feeEndRange;
  String? _countryCode;

  ForeignUniversityBloc() : super(ForeignUniversityInitial()) {
    on<ForeignUniversityLoad>((event, emit) async {
      // Use event filters or fallback to saved filters
      _feeStartRange = event.feeStartRange ?? null;
      _feeEndRange = event.feeEndRange ?? null;
      _countryCode = event.countryCode ?? null;

      if (_feeEndRange == 100000) {
        _feeEndRange = 999999;
      }

      // Prepare query parameters
      final queryParams = {
        'feeStartRange': _feeStartRange?.toString(),
        'feeEndRange': _feeEndRange?.toString(),
        'countryCode': _countryCode,
        'page': event.page?.toString() ?? '1',
        'limit': event.limit?.toString() ?? '20',
      }..removeWhere((key, value) => value == null);

      final queryString = Uri(queryParameters: queryParams).query;
      print(queryString);

      try {
        final data = await ApiClient.get(
            'api/resources/foreign/universities?$queryString');
        // if(data['message'].contains(''))
        if (data['success']) {
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
              currentCountryCode: _countryCode,
              currentPage: event.page ?? 1, // Ensure non-null currentPage
              totalPages: totalPages, // Total pages from the API response
              feeStartRange: _feeStartRange, // Save filter values
              feeEndRange: _feeEndRange, // Save filter values
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
