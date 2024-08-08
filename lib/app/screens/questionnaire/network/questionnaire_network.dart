import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';

class QuestionnaireNetwork {
  Future<QuestionnaireModel> loadTasks() async {
    try {
      final String response =
          await rootBundle.loadString('assets/testingmaterials/mbti.json');
      final Map<String, dynamic> data = json.decode(response);
      return QuestionnaireModel.fromJson(data);
    } catch (e) {
      print('Error loading quiz data: $e');
      rethrow;
    }
  }
}
