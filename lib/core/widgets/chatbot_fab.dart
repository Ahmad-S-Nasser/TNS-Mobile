import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

/// AI chatbot — confirmed backend roadmap-only (no chat/AI service exists,
/// not even a stubbed endpoint). Shown as a visible, discoverable entry
/// point per product decision (prefer visible-but-disabled over removal),
/// but tapping surfaces an honest "coming soon" message instead of opening
/// a chat UI that would look functional while doing nothing.
class ChatbotFAB extends StatelessWidget {
  const ChatbotFAB({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('المساعد الذكي قيد التطوير، ترقبوه قريباً')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse ring
        Container(
          width: 58.W,
          height: 58.H,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryBlue.withValues(alpha: 0.55),
              width: 2.W,
            ),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.55, 1.55),
              duration: 2400.ms,
              curve: Curves.easeOut,
            )
            .fadeOut(duration: 1680.ms), // 70% of 2400ms is ~1680ms

        // Main FAB
        GestureDetector(
          onTap: () => _showComingSoon(context),
          child: Container(
            width: 58.W,
            height: 58.H,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B59B2).withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.aiBot,
                width: 30.W,
                height: 30.H,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0, 0),
              end: const Offset(1, 1),
              duration: 600.ms,
              curve: Curves.elasticOut,
            )
            .moveY(
              begin: 0,
              end: -8,
              duration: 600.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .moveY(
              begin: 0,
              end: 8,
              duration: 600.ms,
              curve: Curves.easeInOut,
            ),
      ],
    );
  }
}
