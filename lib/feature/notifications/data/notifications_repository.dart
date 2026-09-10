import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/notifications/data/model/notification_model.dart';

class NotificationsRepository {
  final ApiClient _client;

  NotificationsRepository(this._client);

  Future<List<NotificationModel>> getNotifications() async {
    final data = await _client.get(ApiConstants.notifications);
    final list = data is List ? data : (data as Map)['items'] ?? [];
    return (list as List)
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// No meaningful response body is expected (treat 200/204 the same) —
  /// callers should update local state themselves (see
  /// `NotificationsCubit.markAsRead`) rather than parsing a response here.
  Future<void> markAsRead(String id) {
    return _client.patch(ApiConstants.notificationMarkRead(id));
  }
}
