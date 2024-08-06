import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';
import 'package:wg_app/app/screens/questionnaire/model/task_model.dart';

class QuestionnaireNetwork {
  Future<List<Task>> loadTasks() async {
    final String responce =
        await rootBundle.loadString('assets/jsondata/guidanceTasks.json');
    final List<dynamic> data = json.decode(responce);
    return data.map((task) => Task.fromJson(task)).toList();
  }
}
