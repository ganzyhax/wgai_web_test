import 'dart:developer';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/questionnaire/model/testing_model.dart';

class QuestionnaireNetwork {
  Future<TestingModel?> getQuestionnaire(String testingCode) async {
    final response = await ApiClient.get('api/testingMaterials/$testingCode');
    // final response = await ApiClient.get('api/testingMaterials/qstnNine');
    if (response['success']) {
      final testData = response['data'];
      try {
        final testModel = TestingModel.fromJson(testData);
        return testModel;
      } catch (e) {
        log('Error parsing questionnaire data: $e');
        return null;
      }
    } else {
      // log('Failed to load questionnaire: ${response['data']}');
    }
    return null;
  }

  Future<void> submitAnswers(
      List<List<int>> answers, String taskId, bool isGuidanceTask) async {
    var correctRoute = "guidanceTasks";
    if (!isGuidanceTask) {
      correctRoute = "counselorTasks";
    }
    print("before send");
    var response = await ApiClient.post('api/$correctRoute/submitResponse',
        {"taskId": taskId, "taskResponse": answers});
    if (response['success']) {
      print("successfully sent");
    }
  }
}
