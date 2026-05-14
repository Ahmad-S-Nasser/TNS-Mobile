import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class SplashLogo extends StatelessWidget {
  final AnimationController entryController;
  final AnimationController loopController;
  final Animation<double> logoScale;
  final Animation<double> contentFadeUp;
  final Animation<double> barWidth;

  const SplashLogo({
    super.key,
    required this.entryController,
    required this.loopController,
    required this.logoScale,
    required this.contentFadeUp,
    required this.barWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: entryController,
      builder: (context, child) {
        final fadeValue = contentFadeUp.value;
        final slideOffset = (1.0 - fadeValue) * 20.0;

        return Column(
          children: [
            // Logo Card with Glowing Pulse
            _buildAnimatedLogo(),

            30.vS,

            // App Name
            Opacity(
              opacity: fadeValue,
              child: Transform.translate(
                offset: Offset(0, slideOffset),
                child: Column(
                  children: [
                    Text(
                      'Tips N Steps',
                      style: TextStyle(
                        fontSize: 36.SP,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            offset: const Offset(0, 2),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                    9.vS,
                    // Orange accent bar
                    Container(
                      height: 3.5.H,
                      width: 68.W * barWidth.value,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.orange,
                            Color(0xFFF58F45),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.4, 0.6, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(99.R),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            13.vS,

            // Tagline
            Opacity(
              opacity: fadeValue,
              child: Transform.translate(
                offset: Offset(0, slideOffset),
                child: Text(
                  "Your child's growth journey starts here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5.SP,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.65),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: loopController,
        builder: (context, child) {
          // Pulsing glow effects
          final pulse1 =
              0.94 + 0.12 * math.sin(loopController.value * 2 * math.pi);
          final pulse2 = 0.94 +
              0.12 * math.sin((loopController.value + 0.1) * 2 * math.pi);

          return ScaleTransition(
            scale: logoScale,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer pulse ring - warm orange glow
                Container(
                  width: 210.W * pulse1,
                  height: 210.H * pulse1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.orange.withValues(alpha: 0.20),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Inner glow - warm teal
                Container(
                  width: 160.W * pulse2,
                  height: 160.H * pulse2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.teal.withValues(alpha: 0.28),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Logo Card
                Image.asset(
                  AppImages.logo,
                  fit: BoxFit.contain,
                  width: 152.W,
                  height: 152.H,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
