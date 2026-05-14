import 'package:flutter/material.dart';

class GrowthFieldModel {
  final int id;
  final String title;
  final String description;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;
  final Color bgColor;
  final String iconPath;
  final Map<String, dynamic> stats;
  final List<Map<String, dynamic>> milestones;
  final List<String> tips;
  final List<Map<String, dynamic>> metrics;

  GrowthFieldModel({
    required this.id,
    required this.title,
    required this.description,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
    required this.bgColor,
    required this.iconPath,
    required this.stats,
    required this.milestones,
    required this.tips,
    required this.metrics,
  });
}
