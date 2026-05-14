import 'package:flutter/material.dart';

class EmergencyNumberModel {
  final int id;
  final String title;
  final String number;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;
  final String description;
  final String available;

  EmergencyNumberModel({
    required this.id,
    required this.title,
    required this.number,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
    required this.description,
    required this.available,
  });
}

class EmergencyTipModel {
  final int id;
  final String title;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;
  final String severity;
  final IconData icon;
  final List<String> steps;
  final String warning;
  final List<String> prevention;

  EmergencyTipModel({
    required this.id,
    required this.title,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
    required this.severity,
    required this.icon,
    required this.steps,
    required this.warning,
    required this.prevention,
  });
}

class FirstAidKitItemModel {
  final String item;
  final String emoji;

  FirstAidKitItemModel({
    required this.item,
    required this.emoji,
  });
}
