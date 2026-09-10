import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/chatbot_fab.dart';
import 'package:tips_n_steps/core/widgets/community_header_icon.dart';
import 'package:tips_n_steps/feature/notifications/view/components/notification_header_icon.dart';

class MainLayoutWrapper extends StatelessWidget {
  final Widget child;
  final bool showOverlays;

  const MainLayoutWrapper({
    super.key,
    required this.child,
    this.showOverlays = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showOverlays) return child;

    return Stack(
      children: [
        child,
        const CommunityHeaderIcon(),
        // Opposite corner from CommunityHeaderIcon so the two overlays never
        // collide; reads NotificationsCubit from an app-root provider (see
        // lib/main.dart) for a badge count that stays live across screens.
        const NotificationHeaderIcon(),
        Positioned(
          bottom: 110.H,
          left: 16.W,
          child: const ChatbotFAB(),
        ),
      ],
    );
  }
}
