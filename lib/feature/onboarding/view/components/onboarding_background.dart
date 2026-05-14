import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class OnboardingBackground extends StatelessWidget {
  final AnimationController pulseController;

  const OnboardingBackground({
    super.key,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Gradient
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.48, -0.88),
              end: Alignment(-0.48, 0.88),
              colors: [
                Color(0xFF2563EB),
                Color(0xFF1B59B2),
                Color(0xFF0D3A7A),
              ],
            ),
          ),
        ),

        // Animated Pulses
        AnimatedBuilder(
          animation: pulseController,
          builder: (context, child) {
            return Stack(
              children: [
                // Left Blue Pulse
                Positioned(
                  left: -50.W,
                  top: 140.H,
                  child: Opacity(
                    opacity: 0.18 +
                        (0.12 * math.sin(pulseController.value * 2 * math.pi)),
                    child: Transform.scale(
                      scale: 1.0 +
                          (0.05 *
                              math.sin(pulseController.value * 2 * math.pi)),
                      child: Container(
                        width: 340.W,
                        height: 310.H,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1B59B2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                // Right Orange Pulse
                Positioned(
                  right: -80.W,
                  top: 240.H,
                  child: Opacity(
                    opacity: 0.07 +
                        (0.05 *
                            math.sin(
                                (pulseController.value + 0.2) * 2 * math.pi)),
                    child: Transform.scale(
                      scale: 1.0 +
                          (0.04 *
                              math.sin(
                                  (pulseController.value + 0.2) * 2 * math.pi)),
                      child: Container(
                        width: 320.W,
                        height: 290.H,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF37423),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),

                // Decorative Star Accents
                Positioned(
                  left: 40.W,
                  top: 470.H,
                  child: Opacity(
                    opacity: 0.22,
                    child: CustomPaint(
                      size: Size(16.W, 16.H),
                      painter: StarAccentPainter(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 40.W,
                  top: 520.H,
                  child: Opacity(
                    opacity: 0.18,
                    child: CustomPaint(
                      size: Size(14.W, 14.H),
                      painter:
                          StarAccentPainter(color: const Color(0xFFF37423)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class StarAccentPainter extends CustomPainter {
  final Color color;

  StarAccentPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    canvas.drawLine(Offset(w * 0.5, 0), Offset(w * 0.5, h), paint);
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
