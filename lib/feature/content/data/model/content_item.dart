/// Content section catalog entry — `GET /mobile/content/sections` returns
/// `{id,name,slug}[]`. `name` is whatever label the backend hands back (no
/// separate localization endpoint exists), used as-is for filter chips.
class ContentSection {
  final int id;
  final String name;
  final String slug;

  const ContentSection({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ContentSection.fromJson(Map<String, dynamic> json) => ContentSection(
        id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
        name: json['name']?.toString() ?? '',
        slug: json['slug']?.toString() ?? '',
      );
}

/// Mirrors the real content item shape returned by `GET /mobile/content`,
/// `GET /mobile/content/section/{section}` and `GET /mobile/content/{id}`.
///
/// The old UI-only fields (`duration`, `expert`, `category`/`categoryName`,
/// string `views`, `rating` as a bare double, `description`, `topics`) had no
/// backend equivalent and have been dropped in favor of the real fields
/// below, with a few presentation-only getters kept for the widgets that
/// still want a formatted string.
class ContentItem {
  final String id;
  final String section;
  final String type;
  final String status;
  final String title;
  final String body;
  final String? summary;
  final String? thumbnailUrl;
  final String? videoUrl;
  final List<String> tags;
  final int? minAgeMonths;
  final int? maxAgeMonths;
  final int viewCount;
  final double averageRating;
  final DateTime? publishedAt;

  const ContentItem({
    required this.id,
    required this.section,
    required this.type,
    required this.status,
    required this.title,
    required this.body,
    this.summary,
    this.thumbnailUrl,
    this.videoUrl,
    this.tags = const [],
    this.minAgeMonths,
    this.maxAgeMonths,
    this.viewCount = 0,
    this.averageRating = 0,
    this.publishedAt,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) => ContentItem(
        id: json['id']?.toString() ?? '',
        section: json['section']?.toString() ?? '',
        type: json['type']?.toString() ?? 'article',
        status: json['status']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        body: json['body']?.toString() ?? '',
        summary: json['summary']?.toString(),
        thumbnailUrl: json['thumbnailUrl']?.toString(),
        videoUrl: json['videoUrl']?.toString(),
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
        minAgeMonths: json['minAgeMonths'] == null
            ? null
            : int.tryParse(json['minAgeMonths'].toString()),
        maxAgeMonths: json['maxAgeMonths'] == null
            ? null
            : int.tryParse(json['maxAgeMonths'].toString()),
        viewCount: int.tryParse(json['viewCount']?.toString() ?? '') ?? 0,
        averageRating:
            double.tryParse(json['averageRating']?.toString() ?? '') ?? 0,
        publishedAt: json['publishedAt'] == null
            ? null
            : DateTime.tryParse(json['publishedAt'].toString()),
      );

  bool get isVideo => type.toLowerCase() == 'video';

  /// No backend field carries an emoji/icon — derived client-side from type.
  String get emoji => isVideo ? '🎬' : '📄';

  /// Falls back to a truncated body when the backend didn't send a summary.
  String get displaySummary {
    if (summary != null && summary!.trim().isNotEmpty) return summary!;
    if (body.length <= 140) return body;
    return '${body.substring(0, 140)}...';
  }

  /// Compact "12.5k" style formatting for the raw `viewCount`.
  String get formattedViewCount {
    if (viewCount >= 1000000) {
      return '${(viewCount / 1000000).toStringAsFixed(1)}م';
    }
    if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}k';
    }
    return viewCount.toString();
  }

  String get formattedPublishedAt {
    final date = publishedAt;
    if (date == null) return '';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
