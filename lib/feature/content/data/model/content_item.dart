class ContentItem {
  final int id;
  final String type;
  final String title;
  final String duration;
  final String category;
  final String categoryName;
  final String emoji;
  final String expert;
  final String views;
  final double rating;
  final String description;
  final List<String> topics;

  ContentItem({
    required this.id,
    required this.type,
    required this.title,
    required this.duration,
    required this.category,
    required this.categoryName,
    required this.emoji,
    required this.expert,
    required this.views,
    required this.rating,
    required this.description,
    required this.topics,
  });
}
