import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TestModel {
  String? message;
  TestingMaterial? testingMaterial;

  TestModel({this.message, this.testingMaterial});

  TestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    testingMaterial = json['testingMaterial'] != null
        ? TestingMaterial.fromJson(json['testingMaterial'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (testingMaterial != null) {
      data['testingMaterial'] = testingMaterial!.toJson();
    }
    return data;
  }
}

class TestingMaterial {
  String? sId;
  String? testingCode;
  String? testType;
  Thumbnail? thumbnail;
  int? timeLimit;
  Thumbnail? title;
  Thumbnail? description;
  List<Problems>? problems;

  TestingMaterial(
      {this.sId,
      this.testingCode,
      this.testType,
      this.thumbnail,
      this.timeLimit,
      this.title,
      this.description,
      this.problems});

  TestingMaterial.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testingCode = json['testingCode'];
    testType = json['testType'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    timeLimit = json['timeLimit'];
    title = json['title'] != null ? Thumbnail.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Thumbnail.fromJson(json['description'])
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
    data['_id'] = sId;
    data['testingCode'] = testingCode;
    data['testType'] = testType;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
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

class Thumbnail {
  String? kk;
  String? ru;
  String? en;

  Thumbnail({this.kk, this.ru, this.en});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    kk = json['kk'];
    ru = json['ru'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kk'] = kk;
    data['ru'] = ru;
    data['en'] = en;
    return data;
  }

  String getLocalizedString(BuildContext context) {
    final locale = context.locale.languageCode;
    if (locale == 'ru') {
      return ru ?? kk!;
    } else if (locale == 'kk') {
      return kk ?? ru!;
    } else {
      return en ?? ru ?? kk ?? '';
    }
  }

  tr() {}
}

class Problems {
  String? problemType;
  Thumbnail? question;
  List<Options>? options;

  Problems({this.problemType, this.question, this.options});

  Problems.fromJson(Map<String, dynamic> json) {
    problemType = json['problemType'];
    question =
        json['question'] != null ? Thumbnail.fromJson(json['question']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? nextQuestionIndex;
  Thumbnail? answer;

  Options({this.nextQuestionIndex, this.answer});

  Options.fromJson(Map<String, dynamic> json) {
    nextQuestionIndex = json['nextQuestionIndex'];
    answer = json['answer'] != null ? Thumbnail.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextQuestionIndex'] = nextQuestionIndex;
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    return data;
  }
}
