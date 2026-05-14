import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/chatbot_fab.dart';
import 'package:tips_n_steps/core/widgets/community_header_icon.dart';

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
        Positioned(
          bottom: 110.H,
          left: 16.W,
          child: const ChatbotFAB(),
        ),
      ],
    );
  }
}
