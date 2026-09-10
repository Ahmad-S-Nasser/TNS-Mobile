class AgeGroupModel {
  final String id;
  final String name;
  final int minAgeMonths;
  final int maxAgeMonths;

  const AgeGroupModel({
    required this.id,
    required this.name,
    required this.minAgeMonths,
    required this.maxAgeMonths,
  });

  factory AgeGroupModel.fromJson(Map<String, dynamic> json) => AgeGroupModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        minAgeMonths: (json['minAgeMonths'] as num?)?.toInt() ?? 0,
        maxAgeMonths: (json['maxAgeMonths'] as num?)?.toInt() ?? 0,
      );

  bool covers(int ageInMonths) =>
      ageInMonths >= minAgeMonths && ageInMonths <= maxAgeMonths;
}

/// Minimal, self-contained child option for the checklist's child picker.
/// Deliberately not the full Children feature's model — this feature only
/// needs id/name/birth date and avoids a cross-feature build dependency.
class ChildOption {
  final String id;
  final String fullName;
  final DateTime? dateOfBirth;

  const ChildOption({required this.id, required this.fullName, this.dateOfBirth});

  factory ChildOption.fromJson(Map<String, dynamic> json) => ChildOption(
        id: json['id']?.toString() ?? '',
        fullName: json['fullName']?.toString() ?? '',
        dateOfBirth: DateTime.tryParse(json['dateOfBirth']?.toString() ?? ''),
      );

  int get ageInMonths {
    final dob = dateOfBirth;
    if (dob == null) return 0;
    final now = DateTime.now();
    return (now.year - dob.year) * 12 + (now.month - dob.month);
  }
}
