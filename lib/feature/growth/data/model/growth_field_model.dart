import 'package:flutter/material.dart';

/// One of the three real metric types a [GrowthSkillModel] can use
/// (`GrowthSkill.MetricType` in the backend — a `SkillType` enum with only
/// Yes/No also exists in the backend but is dead code, never referenced).
enum GrowthMetricType { boolean, numeric, scale, unknown }

GrowthMetricType metricTypeFromString(String? value) {
  switch (value) {
    case 'Boolean':
      return GrowthMetricType.boolean;
    case 'Numeric':
      return GrowthMetricType.numeric;
    case 'Scale':
      return GrowthMetricType.scale;
    default:
      return GrowthMetricType.unknown;
  }
}

/// A single milestone rule for a skill. Note: the backend DTO does not
/// include which age group a rule belongs to — only [expectedMonth]. The
/// checklist form matches a rule to the child's current age group by
/// checking whether [expectedMonth] falls within that age group's
/// min/max month range (see GrowthRepository.pickMilestoneForAgeGroup).
class GrowthMilestoneModel {
  final String ruleId;
  final int expectedMonth;
  final bool? expectedBoolean;
  final double? minValue;
  final double? optimalMin;
  final double? optimalMax;
  final double? maxValue;
  final int? minScaleValue;
  final int? optimalScaleValue;

  const GrowthMilestoneModel({
    required this.ruleId,
    required this.expectedMonth,
    this.expectedBoolean,
    this.minValue,
    this.optimalMin,
    this.optimalMax,
    this.maxValue,
    this.minScaleValue,
    this.optimalScaleValue,
  });

  factory GrowthMilestoneModel.fromJson(Map<String, dynamic> json) =>
      GrowthMilestoneModel(
        ruleId: json['ruleId']?.toString() ?? '',
        expectedMonth: (json['expectedMonth'] as num?)?.toInt() ?? 0,
        expectedBoolean: json['expectedBoolean'] as bool?,
        minValue: (json['minValue'] as num?)?.toDouble(),
        optimalMin: (json['optimalMin'] as num?)?.toDouble(),
        optimalMax: (json['optimalMax'] as num?)?.toDouble(),
        maxValue: (json['maxValue'] as num?)?.toDouble(),
        minScaleValue: (json['minScaleValue'] as num?)?.toInt(),
        optimalScaleValue: (json['optimalScaleValue'] as num?)?.toInt(),
      );
}

class GrowthSkillModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final GrowthMetricType metricType;
  final String? unit;
  final int weight;
  final int sortOrder;
  final List<GrowthMilestoneModel> milestones;
  final List<String> improvementTips;

  const GrowthSkillModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.metricType,
    this.unit,
    required this.weight,
    required this.sortOrder,
    required this.milestones,
    required this.improvementTips,
  });

  factory GrowthSkillModel.fromJson(Map<String, dynamic> json) =>
      GrowthSkillModel(
        id: json['id']?.toString() ?? '',
        titleAr: json['titleAr']?.toString() ?? '',
        titleEn: json['titleEn']?.toString() ?? '',
        descriptionAr: json['descriptionAr']?.toString() ?? '',
        descriptionEn: json['descriptionEn']?.toString() ?? '',
        metricType: metricTypeFromString(json['metricType']?.toString()),
        unit: json['unit']?.toString(),
        weight: (json['weight'] as num?)?.toInt() ?? 1,
        sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
        milestones: (json['milestones'] as List? ?? [])
            .map((e) => GrowthMilestoneModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        improvementTips: (json['improvementTips'] as List? ?? [])
            .map((e) => e is Map ? (e['ar']?.toString() ?? '') : e.toString())
            .where((s) => s.isNotEmpty)
            .toList(),
      );
}

/// Mirrors `GET /mobile/growth/fields` (summary) and
/// `GET /mobile/growth/fields/{id}` (adds [skills]). The backend has a
/// single `color` field, not the separate colorStart/colorEnd/bgColor the
/// old prototype model assumed — those are derived client-side below.
class GrowthFieldModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String? iconKey;
  final String? iconUrl;
  final String? imageUrl;
  final String colorHex;
  final int sortOrder;
  final int skillCount;
  final int milestoneCount;

  /// Only populated after fetching the detail endpoint.
  final List<GrowthSkillModel>? skills;

  const GrowthFieldModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    this.iconKey,
    this.iconUrl,
    this.imageUrl,
    required this.colorHex,
    required this.sortOrder,
    required this.skillCount,
    required this.milestoneCount,
    this.skills,
  });

  String get title => nameAr;

  String get description => descriptionAr;

  /// Flattened, display-ready tips pulled from every skill's improvement
  /// tips (only available once [skills] has been loaded via the detail
  /// endpoint).
  List<String> get tips =>
      skills?.expand((s) => s.improvementTips).toList() ?? const [];

  Color get color => _parseHexColor(colorHex) ?? const Color(0xFF1B59B2);

  Color get colorStart => color;

  Color get colorEnd => Color.lerp(color, Colors.black, 0.15) ?? color;

  Color get bgColor => Color.lerp(color, Colors.white, 0.92) ?? color;

  static Color? _parseHexColor(String hex) {
    var value = hex.replaceAll('#', '');
    if (value.length == 6) value = 'FF$value';
    final parsed = int.tryParse(value, radix: 16);
    return parsed != null ? Color(parsed) : null;
  }

  GrowthFieldModel copyWithSkills(List<GrowthSkillModel> skills) =>
      GrowthFieldModel(
        id: id,
        nameAr: nameAr,
        nameEn: nameEn,
        descriptionAr: descriptionAr,
        descriptionEn: descriptionEn,
        iconKey: iconKey,
        iconUrl: iconUrl,
        imageUrl: imageUrl,
        colorHex: colorHex,
        sortOrder: sortOrder,
        skillCount: skillCount,
        milestoneCount: milestoneCount,
        skills: skills,
      );

  factory GrowthFieldModel.fromJson(Map<String, dynamic> json) =>
      GrowthFieldModel(
        id: json['id']?.toString() ?? '',
        nameAr: json['nameAr']?.toString() ?? '',
        nameEn: json['nameEn']?.toString() ?? '',
        descriptionAr: json['descriptionAr']?.toString() ?? '',
        descriptionEn: json['descriptionEn']?.toString() ?? '',
        iconKey: json['iconKey']?.toString(),
        iconUrl: json['iconUrl']?.toString(),
        imageUrl: json['imageUrl']?.toString(),
        colorHex: json['color']?.toString() ?? '#1B59B2',
        sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
        skillCount: (json['skillCount'] as num?)?.toInt() ?? 0,
        milestoneCount: (json['milestoneCount'] as num?)?.toInt() ?? 0,
      );

  factory GrowthFieldModel.fromDetailJson(Map<String, dynamic> json) {
    final skills = (json['skills'] as List? ?? [])
        .map((e) => GrowthSkillModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return GrowthFieldModel(
      id: json['id']?.toString() ?? '',
      nameAr: json['nameAr']?.toString() ?? '',
      nameEn: json['nameEn']?.toString() ?? '',
      descriptionAr: json['descriptionAr']?.toString() ?? '',
      descriptionEn: json['descriptionEn']?.toString() ?? '',
      iconKey: json['iconKey']?.toString(),
      iconUrl: json['iconUrl']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      colorHex: json['color']?.toString() ?? '#1B59B2',
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      skillCount: skills.length,
      milestoneCount:
          skills.fold<int>(0, (sum, s) => sum + s.milestones.length),
      skills: skills,
    );
  }
}
