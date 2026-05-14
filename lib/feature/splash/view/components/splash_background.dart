import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final AnimationController loopController;

  const SplashBackground({
    super.key,
    required this.loopController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Pulsing background decorations
        Positioned.fill(
          child: RepaintBoundary(
            child: ExcludeSemantics(
              child: AnimatedBuilder(
                animation: loopController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SplashBackgroundPainter(
                      animation: loopController.value,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Top soft warmth overlay
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 300.W,
            height: 300.H,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.8, -0.7),
                radius: 1.0,
                colors: [
                  AppColors.orange.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashBackgroundPainter extends CustomPainter {
  final double animation;

  SplashBackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerOpacity = (math.sin(animation * 2 * math.pi) + 1) / 2;

    // 1. Shimmering Blobs
    _drawBlob(
      canvas,
      size,
      const Offset(-20, 130),
      190,
      170,
      AppColors.teal.withValues(alpha: 0.22 * (0.8 + 0.2 * shimmerOpacity)),
    );
    _drawBlob(
      canvas,
      size,
      Offset(size.width + 30, size.height - 144),
      210,
      190,
      const Color(0xFF0D4F45)
          .withValues(alpha: 0.5 * (0.8 + 0.2 * shimmerOpacity)),
    );
    _drawBlob(
      canvas,
      size,
      const Offset(60, 760),
      130,
      120,
      AppColors.teal.withValues(alpha: 0.15 * (0.8 + 0.2 * shimmerOpacity)),
    );
    _drawBlob(
      canvas,
      size,
      const Offset(330, 90),
      110,
      95,
      AppColors.orange.withValues(alpha: 0.09 * (0.8 + 0.2 * shimmerOpacity)),
    );

    // 2. Arcs
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color =
          AppColors.orange.withValues(alpha: 0.20 * (1 - 0.1 * shimmerOpacity));

    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width, 0), width: 300, height: 280),
      arcPaint,
    );
    arcPaint.strokeWidth = 1.0;
    arcPaint.color = AppColors.orange.withValues(
      alpha: 0.13 * (1 - 0.1 * shimmerOpacity),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width, 0), width: 200, height: 190),
      arcPaint,
    );

    final tealArcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color =
          AppColors.teal.withValues(alpha: 0.22 * (1 - 0.1 * shimmerOpacity));
    canvas.drawOval(
      Rect.fromCenter(center: Offset(0, size.height), width: 290, height: 270),
      tealArcPaint,
    );

    // 3. Floating Dots
    _drawFloatingDot(
      canvas,
      size,
      const Offset(40, 220),
      6,
      AppColors.orange,
      0,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(355, 300),
      5,
      Colors.white,
      0.6,
    );
    _drawFloatingDot(canvas, size, const Offset(70, 580), 4, Colors.white, 1.1);
    _drawFloatingDot(
      canvas,
      size,
      const Offset(345, 615),
      7,
      AppColors.orange,
      0.3,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(198, 118),
      3,
      Colors.white,
      0.9,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(308, 168),
      4,
      AppColors.teal,
      1.4,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(88, 700),
      5,
      AppColors.orange,
      0.7,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(332, 755),
      3,
      Colors.white,
      1.6,
    );
    _drawFloatingDot(
      canvas,
      size,
      const Offset(160, 760),
      4,
      AppColors.teal,
      1.0,
    );

    // 4. Star cross accents
    _drawStar(canvas, const Offset(52, 162), 7, shimmerOpacity);
    _drawStar(canvas, const Offset(338, 258), 6, shimmerOpacity);
    _drawStar(canvas, const Offset(78, 645), 6, shimmerOpacity);
    _drawStar(canvas, const Offset(348, 698), 5, shimmerOpacity);
    _drawStar(canvas, const Offset(178, 92), 5, shimmerOpacity);

    // 5. Texture Grid
    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.08);
    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 7; col++) {
        canvas.drawCircle(
          Offset(28 + col * 56.0, size.height - 100 + row * 22.0),
          1.5,
          dotPaint,
        );
      }
    }
  }

  void _drawBlob(
    Canvas canvas,
    Size size,
    Offset center,
    double rx,
    double ry,
    Color color,
  ) {
    final paint = Paint()..color = color;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      paint,
    );
  }

  void _drawFloatingDot(
    Canvas canvas,
    Size size,
    Offset center,
    double r,
    Color color,
    double delay,
  ) {
    final floatY = math.sin((animation + delay) * 2 * math.pi) * 7;
    final paint = Paint()..color = color.withValues(alpha: 0.55);
    canvas.drawCircle(center.translate(0, floatY), r, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double s, double shimmer) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.28 * shimmer)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center.translate(-s, 0), center.translate(s, 0), paint);
    canvas.drawLine(center.translate(0, -s), center.translate(0, s), paint);
  }

  @override
  bool shouldRepaint(SplashBackgroundPainter oldDelegate) => true;
}
