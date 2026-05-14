import 'package:flutter/material.dart';

class BehavioralProblemModel {
  final int id;
  final String title;
  final String illustration;
  final Color colorStart;
  final Color colorEnd;
  final String description;
  final List<String> causes;
  final List<String> solutions;
  final List<String> expertTips;

  BehavioralProblemModel({
    required this.id,
    required this.title,
    required this.illustration,
    required this.colorStart,
    required this.colorEnd,
    required this.description,
    required this.causes,
    required this.solutions,
    required this.expertTips,
  });
}
