import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';

class QuestionnaireNetwork {
  Future<List<Question>> fetchQuestions() async {
    return [
      Question("What's the capital of France?", ["Paris", "Berlin", "Rome"]),
      Question("What's 2 + 2?", ["3", "4", "5"]),
    ];
  }
}
