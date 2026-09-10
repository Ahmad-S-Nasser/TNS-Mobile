/// `Hospitals` is a confirmed real `ContentSection` enum value, so this is
/// backed by real content. `distance` has no backend equivalent at all (no
/// geolocation on a content item) and stays permanently null — the UI hides
/// its row rather than showing a fake/zero value. `rating` DOES have a real
/// backend equivalent (`averageRating` on every content item) and is wired
/// through; it's still nullable since not every item is guaranteed to carry
/// one. `phone` has no dedicated field either — best-effort extracted from
/// `tags` only if a tag looks like a phone number, otherwise left null (call
/// button hidden) rather than invented.
class HospitalModel {
  final String id;
  final String name;
  final String description;
  final String? thumbnailUrl;
  final String? phone;
  final double? distanceKm;
  final double? rating;
  final String illustration;

  HospitalModel({
    required this.id,
    required this.name,
    required this.description,
    this.thumbnailUrl,
    this.phone,
    this.distanceKm,
    this.rating,
    required this.illustration,
  });

  static const List<String> _illustrations = ['🏥', '⚕️', '🚑'];

  factory HospitalModel.fromJson(Map<String, dynamic> json, {int index = 0}) {
    return HospitalModel(
      id: json['id'].toString(),
      name: json['title'] as String? ?? '',
      description: (json['body'] as String?) ?? (json['summary'] as String?) ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      phone: _extractPhone(json['tags']),
      // No geolocation field exists on a content item — always null.
      distanceKm: null,
      rating: (json['averageRating'] as num?)?.toDouble(),
      illustration: _illustrations[index % _illustrations.length],
    );
  }

  static String? _extractPhone(dynamic tags) {
    if (tags is! List) return null;
    for (final t in tags) {
      final s = t.toString().trim();
      if (RegExp(r'^[0-9+][0-9+\-\s]{6,}$').hasMatch(s)) return s;
    }
    return null;
  }
}
