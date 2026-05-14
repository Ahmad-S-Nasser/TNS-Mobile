import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

import '../onboarding_view.dart';

class OnboardingSlideIllustration extends StatelessWidget {
  final int index;
  final OnboardingSlide slide;
  final AnimationController floatController;

  const OnboardingSlideIllustration({
    super.key,
    required this.index,
    required this.slide,
    required this.floatController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Floating Illustration with Organic Blob
        RepaintBoundary(
          child: ExcludeSemantics(
            child: AnimatedBuilder(
              animation: floatController,
              builder: (context, child) {
                final floatY =
                    math.sin(floatController.value * 2 * math.pi) * 10.0;
                final rotate = math.sin(floatController.value * 2 * math.pi) *
                    (4 * math.pi / 180);

                return Transform.translate(
                  offset: Offset(0, floatY),
                  child: Transform.rotate(
                    angle: rotate,
                    child: ClipPath(
                      clipper: OrganicBlobClipper(index: index),
                      child: Container(
                        width: 340.W,
                        height: 320.H,
                        color: Colors.white10,
                        child: Stack(
                          children: [
                            // Main Image
                            Positioned.fill(
                              child: Image.asset(
                                slide.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Warm Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xFF16665A)
                                          .withValues(alpha: 0.08),
                                      const Color(0xFF16665A)
                                          .withValues(alpha: 0.35),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Tag Pill
        Positioned(
          top: 28.H,
          right: 32.W,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99.R),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.W, vertical: 6.H),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(99.R),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.32)),
                ),
                child: Text(
                  slide.tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.SP,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrganicBlobClipper extends CustomClipper<Path> {
  final int index;

  OrganicBlobClipper({required this.index});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    if (index % 3 == 0) {
      path.moveTo(w * 0.5, h * 0.1);
      path.cubicTo(w * 0.85, h * 0.1, w * 0.95, h * 0.45, w * 0.9, h * 0.65);
      path.cubicTo(w * 0.85, h * 0.85, w * 0.65, h * 0.95, w * 0.5, h * 0.9);
      path.cubicTo(w * 0.35, h * 0.95, w * 0.15, h * 0.85, w * 0.1, h * 0.65);
      path.cubicTo(w * 0.05, h * 0.45, w * 0.15, h * 0.1, w * 0.5, h * 0.1);
    } else if (index % 3 == 1) {
      path.moveTo(w * 0.5, h * 0.05);
      path.cubicTo(w * 0.9, h * 0.05, w * 1.0, h * 0.4, w * 0.95, h * 0.7);
      path.cubicTo(w * 0.9, h * 0.95, w * 0.6, h * 1.0, w * 0.5, h * 0.95);
      path.cubicTo(w * 0.4, h * 1.0, w * 0.1, h * 0.95, w * 0.05, h * 0.7);
      path.cubicTo(w * 0.0, h * 0.4, w * 0.1, h * 0.05, w * 0.5, h * 0.05);
    } else {
      path.moveTo(w * 0.5, h * 0.15);
      path.cubicTo(w * 0.8, h * 0.15, w * 0.9, h * 0.5, w * 0.85, h * 0.75);
      path.cubicTo(w * 0.8, h * 0.95, w * 0.6, h * 1.0, w * 0.5, h * 0.95);
      path.cubicTo(w * 0.4, h * 1.0, w * 0.2, h * 0.95, w * 0.15, h * 0.75);
      path.cubicTo(w * 0.1, h * 0.5, w * 0.2, h * 0.15, w * 0.5, h * 0.15);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
