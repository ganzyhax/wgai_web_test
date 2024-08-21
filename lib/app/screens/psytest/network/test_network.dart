import 'package:wg_app/app/api/api.dart';
import 'dart:developer';
import 'package:wg_app/app/screens/psytest/model/test_model.dart';

class TestNetwork {
  Future<TestModel?> loadTests() async {
    final response = await ApiClient.get('api/testingMaterials/psytestKlimov');
    if (response['success']) {
      final testData = response['data'];
      log('PsyTest Data: $testData');
      try {
        final testModel = TestModel.fromJson(testData);
        return testModel;
      } catch (e) {
        log('Error parsing PsyTest data: $e');
        return null;
      }
    } else {
      log('Failed to load PsyTest: ${response['data']}');
    }

    return null;
  }

  Future<void> submitTestAnswers(Map<String, dynamic> answers) async {
    final response =
        await ApiClient.post('api/counselorTasks/submitResponse', answers);
    if (response['success']) {
      log('Answers submitted successfully: ${response['data']}');
    } else {
      log('Failed to submit answers: ${response['data']}');
    }
  }
}
