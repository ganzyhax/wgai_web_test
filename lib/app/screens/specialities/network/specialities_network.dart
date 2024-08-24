import 'dart:developer';

import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';

class SpecialitiesNetwork {
  Future<KazSpecialties?> fetchSpecies() async {
    final response = await ApiClient.get('api/resources/kazSpecialties');
    if (response['success']) {
      final speciesData = response['data'];
      log('Kaz Specialities Data: $speciesData');
      try {
        final speciesModel = KazSpecialties.fromJson(speciesData);
        return speciesModel;
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
