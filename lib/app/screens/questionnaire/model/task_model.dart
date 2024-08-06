class Task {
  final String taskId;
  final DateTime createdAt;
  final String guidanceGroupId;
  final int orderInteger;
  final String studentId;
  final String taskType;
  final String completionStatus;
  final String availabilityStatus;
  final Title title;
  final String contentId;
  final String testId;
  final List<CompletionQuiz>? completionQuiz;
  final Result result;

  Task({
    required this.taskId,
    required this.createdAt,
    required this.guidanceGroupId,
    required this.orderInteger,
    required this.studentId,
    required this.taskType,
    required this.completionStatus,
    required this.availabilityStatus,
    required this.title,
    required this.contentId,
    required this.testId,
    required this.completionQuiz,
    required this.result,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      createdAt: DateTime.parse(json['createdAt']),
      guidanceGroupId: json['guidanceGroupId'],
      orderInteger: json['orderInteger'],
      studentId: json['studentId'],
      taskType: json['taskType'],
      completionStatus: json['completionStatus'],
      availabilityStatus: json['availabilityStatus'],
      title: Title.fromJson(json['title']),
      contentId: json['contentId'],
      testId: json['testId'],
      completionQuiz: (json['completionQuiz'] as List<dynamic>?)
          ?.map((e) => CompletionQuiz.fromJson(e))
          .toList(),
      result: Result.fromJson(json['result']),
    );
  }
}

class Title {
  final String kk;
  final String ru;
  final String en;

  Title({required this.kk, required this.ru, required this.en});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      kk: json['kk'],
      ru: json['ru'],
      en: json['en'],
    );
  }
}

class CompletionQuiz {
  final Question question;
  final List<Option> options;
  final int correctIndex;

  CompletionQuiz({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory CompletionQuiz.fromJson(Map<String, dynamic> json) {
    return CompletionQuiz(
      question: Question.fromJson(json['question']),
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e))
          .toList(),
      correctIndex: json['correctIndex'],
    );
  }
}

class Question {
  final String kk;
  final String ru;
  final String en;

  Question({required this.kk, required this.ru, required this.en});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      kk: json['kk'],
      ru: json['ru'],
      en: json['en'],
    );
  }
}

class Option {
  final String kk;
  final String ru;
  final String en;

  Option({required this.kk, required this.ru, required this.en});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      kk: json['kk'],
      ru: json['ru'],
      en: json['en'],
    );
  }
}

class Result {
  final String textResponse;
  final List<String> optionsResponse;
  final List<AttributeScore> attributeScores;
  final String interpretationCode;
  final String timeSubmitted;

  Result({
    required this.textResponse,
    required this.optionsResponse,
    required this.attributeScores,
    required this.interpretationCode,
    required this.timeSubmitted,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      textResponse: json['textResponse'],
      optionsResponse: List<String>.from(json['optionsResponse']),
      attributeScores: (json['attributeScores'] as List<dynamic>)
          .map((e) => AttributeScore.fromJson(e))
          .toList(),
      interpretationCode: json['interpretationCode'],
      timeSubmitted: json['timeSubmitted'],
    );
  }
}

class AttributeScore {
  final Title attributeName;
  final double attributeScore;
  final double totalScore;

  AttributeScore({
    required this.attributeName,
    required this.attributeScore,
    required this.totalScore,
  });

  factory AttributeScore.fromJson(Map<String, dynamic> json) {
    return AttributeScore(
      attributeName: Title.fromJson(json['attributeName']),
      attributeScore: json['attributeScore'].toDouble(),
      totalScore: json['totalScore'].toDouble(),
    );
  }
}
