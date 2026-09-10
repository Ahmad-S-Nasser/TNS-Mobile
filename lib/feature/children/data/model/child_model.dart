/// Mirrors the real `GET/POST/PUT /mobile/children` response shape
/// (`{id, parentId, fullName, dateOfBirth, gender, bloodType?, isActive,
/// createdAt, updatedAt}`).
///
/// `gender` wire values are the pre-existing mobile convention
/// `'male'` / `'female'` (already used by `ChildCard` and the add-child
/// form) — kept as-is so the Growth phase, which will also key off a
/// child's gender, stays consistent.
class ChildModel {
  final String id;
  final String parentId;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender; // 'male' | 'female'
  final String? bloodType;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ChildModel({
    required this.id,
    required this.parentId,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    this.bloodType,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  bool get isMale => gender.toLowerCase() == 'male';

  /// Gender-based emoji — no backend field for this, derived client-side.
  String get emoji => isMale ? '👦' : '👧';

  /// Arabic "X سنة/سنوات و Y شهر/أشهر" age string — no backend display-age
  /// field, derived client-side from [dateOfBirth].
  String get age {
    final now = DateTime.now();
    var years = now.year - dateOfBirth.year;
    var months = now.month - dateOfBirth.month;
    if (now.day < dateOfBirth.day) months -= 1;
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    if (years < 0) years = 0;
    if (months < 0) months = 0;

    if (years <= 0 && months <= 0) return 'أقل من شهر';

    final parts = <String>[];
    if (years > 0) parts.add(_arabicCount(years, 'سنة', 'سنتان', 'سنوات'));
    if (months > 0) {
      parts.add(_arabicCount(months, 'شهر', 'شهران', 'أشهر'));
    }
    return parts.join(' و ');
  }

  static String _arabicCount(
    int count,
    String singular,
    String dual,
    String plural,
  ) {
    if (count == 1) return singular;
    if (count == 2) return dual;
    if (count <= 10) return '$count $plural';
    return '$count $singular';
  }

  factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel(
        id: json['id']?.toString() ?? '',
        parentId: json['parentId']?.toString() ?? '',
        fullName: json['fullName']?.toString() ?? '',
        dateOfBirth:
            DateTime.tryParse(json['dateOfBirth']?.toString() ?? '') ??
                DateTime.now(),
        gender: json['gender']?.toString() ?? 'male',
        bloodType: json['bloodType']?.toString(),
        isActive: json['isActive'] == true,
        createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? ''),
      );

  /// Body shape for `POST`/`PUT` — `parentId` is set server-side from the
  /// JWT and never sent by the client; `id`/`isActive`/timestamps are
  /// server-owned and also excluded.
  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        if (bloodType != null && bloodType!.isNotEmpty)
          'bloodType': bloodType,
      };
}
