class QuestionnaireModel {
  String? testId;
  String? testType;
  String? thumbnail;
  int? timeLimit;
  Titles? title;
  Titles? description;
  List<Problems>? problems;

  QuestionnaireModel(
      {this.testId,
      this.testType,
      this.thumbnail,
      this.timeLimit,
      this.title,
      this.description,
      this.problems});

  QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];
    testType = json['testType'];
    thumbnail = json['thumbnail'];
    timeLimit = json['timeLimit'];
    title = json['title'] != null ? Titles.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Titles.fromJson(json['description'])
        : null;
    if (json['problems'] != null) {
      problems = <Problems>[];
      json['problems'].forEach((v) {
        problems!.add(Problems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testId'] = testId;
    data['testType'] = testType;
    data['thumbnail'] = thumbnail;
    data['timeLimit'] = timeLimit;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (problems != null) {
      data['problems'] = problems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Titles {
  String? en;
  String? ru;
  String? kk;

  Titles({this.en, this.ru, this.kk});

  Titles.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ru = json['ru'];
    kk = json['kk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ru'] = ru;
    data['kk'] = kk;
    return data;
  }
}

class Problems {
  Titles? image;
  Titles? passage;
  String? problemType;
  Titles? question;
  List<Options>? options;

  Problems(
      {this.image,
      this.passage,
      this.problemType,
      this.question,
      this.options});

  Problems.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? Titles.fromJson(json['image']) : null;
    passage = json['passage'] != null ? Titles.fromJson(json['passage']) : null;
    problemType = json['problemType'];
    question =
        json['question'] != null ? Titles.fromJson(json['question']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (passage != null) {
      data['passage'] = passage!.toJson();
    }
    data['problemType'] = problemType;
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? nextQuestionIdx;
  Titles? answer;

  Options({this.nextQuestionIdx, this.answer});

  Options.fromJson(Map<String, dynamic> json) {
    nextQuestionIdx = json['nextQuestionIdx'];
    answer = json['answer'] != null ? Titles.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextQuestionIdx'] = nextQuestionIdx;
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    return data;
  }
}
