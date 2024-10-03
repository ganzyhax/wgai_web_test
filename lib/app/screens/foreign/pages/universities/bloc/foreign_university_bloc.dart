import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'foreign_university_event.dart';
part 'foreign_university_state.dart';

class ForeignUniversityBloc
    extends Bloc<ForeignUniversityEvent, ForeignUniversityState> {
  ForeignUniversityBloc() : super(ForeignUniversityInitial()) {
    on<ForeignUniversityLoad>((event, emit) async {
      // Create a map for the query parameters
      final queryParams = {
        'feeStartRange': event.feeStartRange?.toString(),
        'feeEndRange': event.feeEndRange?.toString(),
        'countryCode': event.countryCode,
        'page': event.page.toString(),
        'limit': event.limit.toString(),
      }..removeWhere((key, value) => value == null);

      // Construct the query string from parameters
      final queryString = Uri(queryParameters: queryParams).query;

      // Make the API call with the constructed URL
      final data = await ApiClient.get(
        'api/resources/foreign/universities?$queryString', // Append the query string to the endpoint
      );

      if (data['success']) {
        log(data.toString());
        emit(ForeignUniversityLoaded(
          data: data['data'],
          currentCountryCode: event.countryCode, // Pass current country code
          currentPage: event.page!, // Pass current page
        ));
      }
    });
  }
}
