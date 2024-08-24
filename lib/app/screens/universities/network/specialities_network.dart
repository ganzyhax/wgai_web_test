import 'dart:developer';

import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';

class UniversitiesNetwork {
  Future<KazUniversity?> fetchSpecies() async {
    final response = await ApiClient.get('api/resources/kazUniversities');
    if (response['success']) {
      final unisData = response['data'];
      log('UniTest Data: $unisData');
      try {
        final unisModel = KazUniversity.fromJson(unisData);
        return unisModel;
      } catch (e) {
        log('Error parsing UniTest data: $e');
        return null;
      }
    } else {
      log('Failed to load PsyTest: ${response['data']}');
    }

    return null;
  }
}
