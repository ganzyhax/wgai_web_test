import 'dart:developer';

import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/psytest/model/test_model.dart';

class QuestionnaireNetwork {
  Future<TestModel?> getQuestionnaire() async {
    final response = await ApiClient.get('api/testingMaterials/qstnNine');
    if (response['success']) {
      final testData = response['data'];
      log('questionnaire Data: $testData');
      try {
        final testModel = TestModel.fromJson(testData);
        return testModel;
      } catch (e) {
        log('Error parsing questionnaire data: $e');
        return null;
      }
    } else {
      log('Failed to load questionnaire: ${response['data']}');
    }
    return null;
  }
}
