/// The backend content item only carries `title`/`body`/`summary`/`tags`/
/// `thumbnailUrl` — no structured `address`/`phone`/`hours`/`days`/`distance`/
/// `rating`/`staff` fields exist behind `section=HealthUnits`. Simplified
/// accordingly: [description] renders the raw `body`, [services] is derived
/// from `tags` (best-effort — tags aren't guaranteed to be service names),
/// and every field with no backend equivalent was dropped rather than faked.
/// `illustration` is a cosmetic emoji cycled by list position, not real data.
class HealthUnitModel {
  final String id;
  final String name;
  final String description;
  final String illustration;
  final List<String> services;
  final String? thumbnailUrl;

  HealthUnitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.illustration,
    required this.services,
    this.thumbnailUrl,
  });

  static const List<String> _illustrations = ['🩺', '🏥', '💉', '🧑‍⚕️'];

  factory HealthUnitModel.fromJson(Map<String, dynamic> json, {int index = 0}) {
    final tags = json['tags'];
    return HealthUnitModel(
      id: json['id'].toString(),
      name: json['title'] as String? ?? '',
      description: (json['body'] as String?) ?? (json['summary'] as String?) ?? '',
      illustration: _illustrations[index % _illustrations.length],
      services: tags is List ? tags.map((e) => e.toString()).toList() : const [],
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }
}

/// A "vaccination schedule" backed by `section=Vaccines` content items rather
/// than a hand-authored age->vaccines table: the backend has no such
/// structured schedule endpoint, only individual content items. Each item's
/// real `minAgeMonths` field (present on every content item per the
/// confirmed shape) is used to derive a human age label and to sort the
/// schedule chronologically; `body` is rendered as the item's detail text
/// instead of a nested vaccines list.
class VaccinationItem {
  final String id;
  final String title;
  final String body;
  final int? minAgeMonths;
  final String ageLabel;

  VaccinationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.minAgeMonths,
    required this.ageLabel,
  });

  factory VaccinationItem.fromJson(Map<String, dynamic> json) {
    final minAge = json['minAgeMonths'] as int?;
    return VaccinationItem(
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      body: (json['body'] as String?) ?? (json['summary'] as String?) ?? '',
      minAgeMonths: minAge,
      ageLabel: _ageLabel(minAge),
    );
  }

  static String _ageLabel(int? minAgeMonths) {
    if (minAgeMonths == null) return 'غير محدد';
    if (minAgeMonths <= 0) return 'عند الولادة';
    if (minAgeMonths < 12) {
      return '$minAgeMonths ${minAgeMonths == 1 ? "شهر" : "أشهر"}';
    }
    final years = minAgeMonths ~/ 12;
    return '$years ${years == 1 ? "سنة" : "سنوات"}';
  }
}
