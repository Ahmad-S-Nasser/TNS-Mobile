part of 'notifications_cubit.dart';

enum NotificationsStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<NotificationModel> notifications;
  final String? errorMessage;

  const NotificationsState({
    required this.status,
    this.notifications = const [],
    this.errorMessage,
  });

  const NotificationsState.initial()
      : this(status: NotificationsStatus.initial);

  /// Derived — badge/list callers read this instead of recomputing.
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationModel>? notifications,
    String? errorMessage,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, notifications, errorMessage];
}
