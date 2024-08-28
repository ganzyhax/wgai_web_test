import 'dart:developer';

import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/atlas/model/professions_model.dart';

class AtlasNetwork {
  Future<ProfessionsModel?> fetchProfessions() async {
    final response = await ApiClient.get('api/occupations/');
    if (response['success']) {
      final professions = response['data'];
      log('Professions Data: $professions');
      try {
        final professionsModel = ProfessionsModel.fromJson(professions);
        return professionsModel;
      } catch (e) {
        log('Error parsing Professions data: $e');
        return null;
      }
    } else {
      log('Failed to load Professions: ${response['data']}');
    }

    return null;
  }
}
