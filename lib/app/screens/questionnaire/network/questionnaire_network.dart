import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';

class QuestionnaireNetwork {
  Future<List<QuestionnaireModel>> fetchQuestions() async {
    return [
      QuestionnaireModel(
          "What's the capital of France?", ["Paris", "Berlin", "Rome"]),
      QuestionnaireModel("What's 2 + 2?", ["3", "4", "5"]),
    ];
  }
}
