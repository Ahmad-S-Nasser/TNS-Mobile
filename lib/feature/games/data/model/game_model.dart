/// The backend only returns `title`/`body`/`summary`/`tags`/`minAgeMonths`/
/// `maxAgeMonths` per content item — no structured `steps`/`description`
/// fields exist behind `section=EducationalGames`. Simplified accordingly:
/// [description] renders `body` (falling back to `summary`), and [steps] is
/// derived by splitting `body` on newlines into pseudo-steps when the text
/// looks line-delimited; otherwise the whole body becomes a single step so
/// nothing is silently dropped. `skill` is best-effort from the first tag
/// (falls back to a generic label since tags aren't guaranteed to be skill
/// names), and `age` is derived from the real `minAgeMonths`/`maxAgeMonths`
/// range. `illustration` is a cosmetic emoji cycled by list position.
class GameModel {
  final String id;
  final String title;
  final String skill;
  final String age;
  final String illustration;
  final String description;
  final List<String> steps;

  GameModel({
    required this.id,
    required this.title,
    required this.skill,
    required this.age,
    required this.illustration,
    required this.description,
    required this.steps,
  });

  static const List<String> _illustrations = ['🎨', '🏃', '🧩', '🎲', '🎯', '🎵'];

  factory GameModel.fromJson(Map<String, dynamic> json, {int index = 0}) {
    final body = (json['body'] as String?) ?? (json['summary'] as String?) ?? '';
    final tags = json['tags'];
    final skill =
        tags is List && tags.isNotEmpty ? tags.first.toString() : 'مهارة عامة';
    return GameModel(
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      skill: skill,
      age: _ageLabel(json['minAgeMonths'] as int?, json['maxAgeMonths'] as int?),
      illustration: _illustrations[index % _illustrations.length],
      description: body,
      steps: _splitSteps(body),
    );
  }

  static String _ageLabel(int? min, int? max) {
    if (min == null && max == null) return '';
    String fmt(int months) =>
        months % 12 == 0 && months > 0 ? '${months ~/ 12} سنوات' : '$months شهر';
    if (min != null && max != null) return '${fmt(min)} - ${fmt(max)}';
    return fmt(min ?? max!);
  }

  static List<String> _splitSteps(String body) {
    final lines = body
        .split(RegExp(r'\r?\n'))
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    if (lines.length > 1) return lines;
    final trimmed = body.trim();
    return trimmed.isNotEmpty ? [trimmed] : [];
  }
}
