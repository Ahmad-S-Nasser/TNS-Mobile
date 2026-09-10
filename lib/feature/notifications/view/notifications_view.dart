import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/notifications/logic/notifications_cubit.dart';
import 'package:tips_n_steps/feature/notifications/view/components/notification_list_item.dart';

/// Notifications list screen. `NotificationsCubit` is expected to already be
/// provided above this route (app-root level, see lib/main.dart) so the
/// same instance backs both this screen and the header badge — this view
/// only triggers a refresh on open, it does not create/own the cubit.
class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
            title: 'الإشعارات',
            subtitle: 'كل التنبيهات الخاصة بك',
            showBackButton: true,
          ),
          Expanded(
            child: BlocConsumer<NotificationsCubit, NotificationsState>(
              listenWhen: (previous, current) =>
                  current.errorMessage != null &&
                  current.errorMessage != previous.errorMessage,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              },
              builder: (context, state) {
                if (state.status == NotificationsStatus.loading ||
                    state.status == NotificationsStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.notifications.isEmpty) {
                  return const EmptyState(
                    emoji: '🔔',
                    title: 'لا توجد إشعارات',
                    description: 'ستظهر هنا أي تنبيهات جديدة خاصة بك',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<NotificationsCubit>().loadNotifications(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
                      return NotificationListItem(
                        notification: notification,
                        onTap: notification.isRead
                            ? null
                            : () => context
                                .read<NotificationsCubit>()
                                .markAsRead(notification.id),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
