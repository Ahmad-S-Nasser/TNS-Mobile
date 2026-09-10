/// One answer in a submitted assessment. Exactly one of [yesNoValue] /
/// [numericValue] should be set, matching the skill's real `metricType`
/// (Boolean -> yesNoValue; Numeric or Scale -> numericValue — Scale is
/// submitted on the same numeric field per the backend's scoring engine,
/// semantically a 0-4 rating).
class SkillResponseInput {
  final String skillId;
  final bool? yesNoValue;
  final double? numericValue;

  const SkillResponseInput({
    required this.skillId,
    this.yesNoValue,
    this.numericValue,
  });

  Map<String, dynamic> toJson() => {
        'skillId': skillId,
        if (yesNoValue != null) 'yesNoValue': yesNoValue,
        if (numericValue != null) 'numericValue': numericValue,
      };
}

class AssessmentResult {
  final String assessmentId;
  final double totalScore;
  final String scoreLevel;
  final Map<String, double> categoryScores;
  final List<String> recommendations;

  const AssessmentResult({
    required this.assessmentId,
    required this.totalScore,
    required this.scoreLevel,
    required this.categoryScores,
    required this.recommendations,
  });

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      AssessmentResult(
        assessmentId: json['assessmentId']?.toString() ?? '',
        totalScore: (json['totalScore'] as num?)?.toDouble() ?? 0,
        scoreLevel: json['scoreLevel']?.toString() ?? '',
        categoryScores: (json['categoryScores'] as Map? ?? {}).map(
          (k, v) => MapEntry(k.toString(), (v as num?)?.toDouble() ?? 0),
        ),
        recommendations: (json['recommendations'] as List? ?? [])
            .map((e) => e.toString())
            .toList(),
      );
}

/// A past assessment as returned by the child history endpoint.
class AssessmentHistoryEntry {
  final String id;
  final String childId;
  final String ageGroupId;
  final DateTime? completedAt;
  final double totalScore;
  final String scoreLevel;

  const AssessmentHistoryEntry({
    required this.id,
    required this.childId,
    required this.ageGroupId,
    this.completedAt,
    required this.totalScore,
    required this.scoreLevel,
  });

  factory AssessmentHistoryEntry.fromJson(Map<String, dynamic> json) =>
      AssessmentHistoryEntry(
        id: json['id']?.toString() ?? '',
        childId: json['childId']?.toString() ?? '',
        ageGroupId: json['ageGroupId']?.toString() ?? '',
        completedAt: DateTime.tryParse(json['completedAt']?.toString() ?? ''),
        totalScore: (json['totalScore'] as num?)?.toDouble() ?? 0,
        scoreLevel: json['scoreLevel']?.toString() ?? '',
      );
}
