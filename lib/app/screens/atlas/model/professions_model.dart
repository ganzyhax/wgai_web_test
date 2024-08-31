import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum ContainerType {
  title,
  section,
  specialities,
  basic,
}

class ProfessionsModel {
  String? message;
  List<Professions>? professions;

  ProfessionsModel({this.message, this.professions});

  ProfessionsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['professions'] != null) {
      professions = <Professions>[];
      json['professions'].forEach((v) {
        professions!.add(Professions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (professions != null) {
      data['professions'] = professions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Professions {
  String? sId;
  String? code;
  String? occupation;
  String? jobZone;
  Interests? interests;
  String? topInterests;
  List<String>? cluster;
  String? careerPathway;
  Title? title;
  Title? description;
  String? areaIconCode;
  List<Sections>? sections;
  Title? summary;
  List<Gops>? gops;
  int? iV;
  ContainerType? containerType;

  Professions({
    this.sId,
    this.code,
    this.occupation,
    this.jobZone,
    this.interests,
    this.topInterests,
    this.cluster,
    this.careerPathway,
    this.title,
    this.description,
    this.areaIconCode,
    this.sections,
    this.summary,
    this.gops,
    this.iV,
    this.containerType,
  });

  Professions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    occupation = json['occupation'];
    jobZone = json['job_zone'];
    interests = json['interests'] != null
        ? Interests.fromJson(json['interests'])
        : null;
    topInterests = json['top_interests'];
    cluster = json['cluster'].cast<String>();
    careerPathway = json['career_pathway'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Title.fromJson(json['description'])
        : null;
    areaIconCode = json['areaIconCode'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    summary = json['summary'] != null ? Title.fromJson(json['summary']) : null;
    if (json['gops'] != null) {
      gops = <Gops>[];
      json['gops'].forEach((v) {
        gops!.add(Gops.fromJson(v));
      });
    }
    iV = json['__v'];

    containerType = determineContainerType(json);
  }

  ContainerType? determineContainerType(Map<String, dynamic> json) {
    if (json.containsKey('title') && json.containsKey('description')) {
      return ContainerType.title;
    } else if (json.containsKey('sections')) {
      return ContainerType.section;
    } else if (json.containsKey('summary')) {
      return ContainerType.basic;
    } else {
      return ContainerType.specialities;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['code'] = code;
    data['occupation'] = occupation;
    data['job_zone'] = jobZone;
    if (interests != null) {
      data['interests'] = interests!.toJson();
    }
    data['top_interests'] = topInterests;
    data['cluster'] = cluster;
    data['career_pathway'] = careerPathway;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['areaIconCode'] = areaIconCode;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (gops != null) {
      data['gops'] = gops!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Interests {
  double? r;
  double? i;
  double? a;
  double? s;
  double? e;
  double? c;

  Interests({this.r, this.i, this.a, this.s, this.e, this.c});

  Interests.fromJson(Map<String, dynamic> json) {
    r = json['R']?.toDouble();
    i = json['I']?.toDouble();
    a = json['A']?.toDouble();
    s = json['S']?.toDouble();
    e = json['E']?.toDouble();
    c = json['C']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['R'] = r;
    data['I'] = i;
    data['A'] = a;
    data['S'] = s;
    data['E'] = e;
    data['C'] = c;
    return data;
  }
}

class Title {
  String? kk;
  String? ru;
  String? en;

  Title({this.kk, this.ru, this.en});

  Title.fromJson(Map<String, dynamic> json) {
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

class Sections {
  Title? title;
  Title? content;

  Sections({this.title, this.content});

  Sections.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    content = json['content'] != null ? Title.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Gops {
  String? code;
  Title? name;

  Gops({this.code, this.name});

  Gops.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'] != null ? Title.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}
