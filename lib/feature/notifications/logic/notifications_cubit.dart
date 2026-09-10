import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/notifications/data/model/notification_model.dart';
import 'package:tips_n_steps/feature/notifications/data/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;

  NotificationsCubit(this._repository)
      : super(const NotificationsState.initial());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    try {
      final notifications = await _repository.getNotifications();
      emit(state.copyWith(
        status: NotificationsStatus.loaded,
        notifications: notifications,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  /// Optimistic local flip — unlike the other features' "re-fetch as source
  /// of truth" pattern, a mark-read is a simple boolean flip that doesn't
  /// warrant a full re-fetch of the list.
  Future<void> markAsRead(String id) async {
    NotificationModel? target;
    for (final n in state.notifications) {
      if (n.id == id) {
        target = n;
        break;
      }
    }
    if (target == null || target.isRead) return;

    final updated = [
      for (final n in state.notifications)
        if (n.id == id) n.copyWith(isRead: true) else n,
    ];
    emit(state.copyWith(notifications: updated));

    try {
      await _repository.markAsRead(id);
    } on AppException catch (e) {
      // Revert the optimistic flip and surface the error.
      final reverted = [
        for (final n in state.notifications)
          if (n.id == id) n.copyWith(isRead: false) else n,
      ];
      emit(state.copyWith(
        notifications: reverted,
        errorMessage: e.userMessage,
      ));
    }
  }
}
