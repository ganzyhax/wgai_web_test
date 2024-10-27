import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class KazUniversity {
  String? message;
  List<Universities>? universities;

  KazUniversity({this.message, this.universities});

  KazUniversity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['universities'] != null) {
      universities = <Universities>[];
      json['universities'].forEach((v) {
        universities!.add(Universities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (universities != null) {
      data['universities'] = universities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Universities {
  String? code;
  Name? name;
  String? website;
  String? regionId;
  Name? regionName;
  Name? type;
  Name? address;
  List<SocialMedia>? socialMedia;
  List<String>? phoneNumbers;
  bool? hasDormitory;
  bool? hasMilitaryDept;
  Name? description;
  List<SpecialtiesUni>? specialties;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Universities(
      {this.code,
      this.name,
      this.website,
      this.regionId,
      this.regionName,
      this.type,
      this.address,
      this.socialMedia,
      this.phoneNumbers,
      this.hasDormitory,
      this.hasMilitaryDept,
      this.description,
      this.specialties,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Universities.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    website = json['website'];
    regionId = json['regionId'];
    regionName = json['regionName'] != null ? Name.fromJson(json['regionName']) : null;
    type = json['type'] != null ? Name.fromJson(json['type']) : null;
    address = json['address'] != null ? Name.fromJson(json['address']) : null;
    if (json['socialMedia'] != null) {
      socialMedia = <SocialMedia>[];
      json['socialMedia'].forEach((v) {
        socialMedia!.add(SocialMedia.fromJson(v));
      });
    }
    phoneNumbers = json['phoneNumbers'].cast<String>();
    hasDormitory = json['hasDormitory'];
    hasMilitaryDept = json['hasMilitaryDept'];
    description = json['description'] != null ? Name.fromJson(json['description']) : null;
    if (json['specialties'] != null) {
      specialties = <SpecialtiesUni>[];
      json['specialties'].forEach((v) {
        specialties!.add(SpecialtiesUni.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['website'] = website;
    data['regionId'] = regionId;
    if (regionName != null) {
      data['regionName'] = regionName!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (socialMedia != null) {
      data['socialMedia'] = socialMedia!.map((v) => v.toJson()).toList();
    }
    data['phoneNumbers'] = phoneNumbers;
    data['hasDormitory'] = hasDormitory;
    data['hasMilitaryDept'] = hasMilitaryDept;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (specialties != null) {
      data['specialties'] = specialties!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Name {
  String? kk;
  String? ru;
  String? en;

  Name(String specialty, {this.kk, this.ru, this.en});

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
      return ru ?? kk ?? en ?? '';
    } else if (locale == 'kk') {
      return kk ?? ru ?? en ?? '';
    } else {
      return en ?? ru ?? kk ?? '';
    }
  }

  tr() {}
}

class SocialMedia {
  String? name;
  String? link;

  SocialMedia({this.name, this.link});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['link'] = link;
    return data;
  }
}

class SpecialtiesUni {
  String? code;
  Name? name;

  SpecialtiesUni({this.code, this.name});

  SpecialtiesUni.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
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
