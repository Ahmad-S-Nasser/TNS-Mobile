import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/notifications/logic/notifications_cubit.dart';

/// Bell icon + unread-count badge for the shared app overlay
/// (`MainLayoutWrapper`). Mirrors `CommunityHeaderIcon`'s visual treatment
/// (translucent white circle over the header gradient) but sits on the
/// opposite side of the screen so the two overlays never collide.
///
/// Reads `NotificationsCubit` from the nearest provider — expected to be
/// supplied once at app-root level (see lib/main.dart) so the badge count
/// stays in sync across every screen without each screen re-fetching it.
class NotificationHeaderIcon extends StatelessWidget {
  const NotificationHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.H,
      right: 16.W,
      child: GestureDetector(
        onTap: () => context.pushNamed(AppRoutes.notifications),
        child: Container(
          width: 44.W,
          height: 44.H,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(16.R),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.4), width: 1.5.W),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 24.SP,
                ),
              ),
              Positioned(
                top: -2.H,
                right: -2.W,
                child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  buildWhen: (previous, current) =>
                      previous.unreadCount != current.unreadCount,
                  builder: (context, state) {
                    if (state.unreadCount <= 0) return const SizedBox.shrink();
                    return _UnreadBadge(count: state.unreadCount);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  final int count;

  const _UnreadBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    final label = count > 9 ? '9+' : '$count';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.W, vertical: 1.H),
      constraints: BoxConstraints(minWidth: 18.W, minHeight: 18.H),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(9.R),
        border: Border.all(color: Colors.white, width: 1.5.W),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.SP,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    );
  }
}
