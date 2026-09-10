import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/notifications/data/model/notification_model.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationListItem({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool unread = !notification.isRead;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.W, vertical: 14.H),
        decoration: BoxDecoration(
          color: unread ? AppColors.primaryBlue.withValues(alpha: 0.05) : null,
          border: const Border(
            bottom: BorderSide(color: AppColors.gray200, width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.H, left: 10.W),
              child: Container(
                width: 8.W,
                height: 8.W,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unread ? AppColors.primaryBlue : Colors.transparent,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 15.SP,
                      fontWeight: unread ? FontWeight.bold : FontWeight.w600,
                      color: AppColors.gray900,
                    ),
                  ),
                  6.vS,
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 13.SP,
                      color: AppColors.gray600,
                      fontWeight: unread ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  8.vS,
                  Text(
                    _formatSentAt(notification.sentAt),
                    style: TextStyle(
                      fontSize: 11.SP,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Lightweight relative/absolute formatting without pulling in `intl` —
  /// this is a brand-new feature with no existing date-formatting utility to
  /// reuse (Phase 11 of the rebuild plan centralizes this app-wide later).
  static String _formatSentAt(DateTime? sentAt) {
    if (sentAt == null) return '';
    final local = sentAt.toLocal();
    final diff = DateTime.now().difference(local);

    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';

    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(local.day)}/${two(local.month)}/${local.year}';
  }
}
