import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class KazSpecialties {
  String? message;
  List<Specialties>? specialties;

  KazSpecialties({this.message, this.specialties});

  KazSpecialties.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['specialties'] != null) {
      specialties = <Specialties>[];
      json['specialties'].forEach((v) {
        specialties!.add(Specialties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (specialties != null) {
      data['specialties'] = specialties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specialties {
  Languages? languages;
  Grants? grants;
  String? code;
  Name? name;
  Name? educationField;
  Name? fieldSpecialization;
  List<ProfileSubjects>? profileSubjects;
  List<UniversitiesSpecial>? universities;
  String? id;
  int? iV;

  Specialties(
      {this.languages,
      this.grants,
      this.code,
      this.name,
      this.educationField,
      this.fieldSpecialization,
      this.profileSubjects,
      this.universities,
      this.id,
      this.iV});

  Specialties.fromJson(Map<String, dynamic> json) {
    languages = json['languages'] != null ? Languages.fromJson(json['languages']) : null;
    grants = json['grants'] != null ? Grants.fromJson(json['grants']) : null;
    code = json['code'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    educationField = json['educationField'] != null ? Name.fromJson(json['educationField']) : null;
    fieldSpecialization = json['fieldSpecialization'] != null ? Name.fromJson(json['fieldSpecialization']) : null;
    if (json['profileSubjects'] != null) {
      profileSubjects = <ProfileSubjects>[];
      json['profileSubjects'].forEach((v) {
        profileSubjects!.add(ProfileSubjects.fromJson(v));
      });
    }
    if (json['universities'] != null) {
      universities = <UniversitiesSpecial>[];
      json['universities'].forEach((v) {
        universities!.add(UniversitiesSpecial.fromJson(v));
      });
    }
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    if (grants != null) {
      data['grants'] = grants!.toJson();
    }
    data['code'] = code;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (educationField != null) {
      data['educationField'] = educationField!.toJson();
    }
    if (fieldSpecialization != null) {
      data['fieldSpecialization'] = fieldSpecialization!.toJson();
    }
    if (profileSubjects != null) {
      data['profileSubjects'] = profileSubjects!.map((v) => v.toJson()).toList();
    }
    if (universities != null) {
      data['universities'] = universities!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['__v'] = iV;
    return data;
  }
}

class Languages {
  bool? kazakh;
  bool? russian;
  bool? english;

  Languages({this.kazakh, this.russian, this.english});

  Languages.fromJson(Map<String, dynamic> json) {
    kazakh = json['Kazakh'];
    russian = json['Russian'];
    english = json['English'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Kazakh'] = kazakh;
    data['Russian'] = russian;
    data['English'] = english;
    return data;
  }
}

class Grants {
  Rural? rural;
  Rural? general;

  Grants({this.rural, this.general});

  Grants.fromJson(Map<String, dynamic> json) {
    rural = json['rural'] != null ? Rural.fromJson(json['rural']) : null;
    general = json['general'] != null ? Rural.fromJson(json['general']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rural != null) {
      data['rural'] = rural!.toJson();
    }
    if (general != null) {
      data['general'] = general!.toJson();
    }
    return data;
  }
}

class Rural {
  int? grantsTotal;
  List<GrantScores>? grantScores;

  Rural({this.grantsTotal, this.grantScores});

  Rural.fromJson(Map<String, dynamic> json) {
    grantsTotal = json['grantsTotal'];
    if (json['grantScores'] != null) {
      grantScores = <GrantScores>[];
      json['grantScores'].forEach((v) {
        grantScores!.add(GrantScores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grantsTotal'] = grantsTotal;
    if (grantScores != null) {
      data['grantScores'] = grantScores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrantScores {
  int? year;
  int? max;
  int? min;

  GrantScores({this.year, this.max, this.min});

  GrantScores.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['max'] = max;
    data['min'] = min;
    return data;
  }
}

class Name {
  String? kk;
  String? ru;
  String? en;

  Name({this.kk, this.ru, this.en});

  Name.fromJson(Map<String, dynamic> json) {
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

class ProfileSubjects {
  String? id;
  Name? name;

  ProfileSubjects({this.id, this.name});

  ProfileSubjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}

class UniversitiesSpecial {
  String? code;
  String? id;
  Name? name;

  UniversitiesSpecial({this.code, this.id, this.name});

  UniversitiesSpecial.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}
