/// Mirrors the real `GET /mobile/notifications` item shape: the per-user
/// `NotificationRecord` (not the old global `AdminNotification` feed). Note
/// the field is `body`, not `message`. `type` is a free-form string such as
/// `QAAnswer`/`AssessmentResult`/`ContentUpdate`/`SystemAlert` — kept as a
/// raw string rather than an enum since the backend may add new types.
class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime? sentAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id']?.toString() ?? '',
        userId: json['userId']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        body: json['body']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
        isRead: json['isRead'] == true,
        sentAt: DateTime.tryParse(json['sentAt']?.toString() ?? ''),
      );

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        userId: userId,
        title: title,
        body: body,
        type: type,
        isRead: isRead ?? this.isRead,
        sentAt: sentAt,
      );
}
