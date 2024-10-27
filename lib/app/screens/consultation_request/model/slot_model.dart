import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SlotResponse {
  final String message;
  final List<SlotModel> data;

  SlotResponse({required this.message, required this.data});

  factory SlotResponse.fromJson(Map<String, dynamic> json) {
    return SlotResponse(
      message: json['message'],
      data: (json['data'] as List).map((slot) => SlotModel.fromJson(slot)).toList(),
    );
  }
}

class SlotModel {
  final String id;
  final String counselorId;
  final String schoolId;
  final DateTime startDate;
  final DateTime endDate;
  final int grade;
  final bool isBooked;
  final bool isSelected; // Add this field


  SlotModel({
    required this.id,
    required this.counselorId,
    required this.schoolId,
    required this.startDate,
    required this.endDate,
    required this.grade,
    required this.isBooked,
    this.isSelected = false
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['_id'],
      counselorId: json['counselorId'],
      schoolId: json['schoolId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      grade: json['grade'],
      isBooked: json['isBooked'],
    );
  }

  SlotModel copyWith({
    String? id,
    String? counselorId,
    String? schoolId,
    DateTime? startDate,
    DateTime? endDate,
    int? grade,
    bool? isBooked,
    bool? isSelected,
  }) {
    return SlotModel(
      id: id ?? this.id,
      counselorId: counselorId ?? this.counselorId,
      schoolId: schoolId ?? this.schoolId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      grade: grade ?? this.grade,
      isBooked: isBooked ?? this.isBooked,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  String get formattedTimeSlot {
    final formatter = DateFormat('HH:mm');
    return '${formatter.format(startDate.toLocal())} - ${formatter.format(endDate.toLocal())}';
  }
}