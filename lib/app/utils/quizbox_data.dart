import 'dart:convert';
import 'package:hive/hive.dart';

class QuizBoxData {
  static final QuizBoxData _instance = QuizBoxData._internal();
  late Box _quizBox;

  QuizBoxData._internal();

  factory QuizBoxData() => _instance;

  Future<void> init() async {
    _quizBox = await Hive.openBox('quizBox');
  }

  /// Save quiz progress (answers and current index)
  Future<void> saveQuizProgress(
      String quizId, List<int> answers, int currentIndex) async {
    final Map<String, dynamic> quizData = {
      'answers': answers,
      'currentIndex': currentIndex,
    };
    await _quizBox.put(quizId, jsonEncode(quizData));
  }

  /// Retrieve quiz progress
  Map<String, dynamic>? getQuizProgress(String quizId) {
    final String? jsonString = _quizBox.get(quizId);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  /// Clear quiz progress for a specific quiz
  Future<void> clearQuizProgress(String quizId) async {
    await _quizBox.delete(quizId);
  }

  /// Check if quiz progress exists
  bool hasQuizProgress(String quizId) {
    return _quizBox.containsKey(quizId);
  }

  /// Clear all stored quiz data
  Future<void> clearAllQuizData() async {
    await _quizBox.clear();
  }
}
