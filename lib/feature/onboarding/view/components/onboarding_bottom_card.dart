import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';

import '../onboarding_view.dart';

class OnboardingBottomCard extends StatelessWidget {
  final int currentIndex;
  final List<OnboardingSlide> slides;
  final VoidCallback onNext;

  const OnboardingBottomCard({
    super.key,
    required this.currentIndex,
    required this.slides,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final slide = slides[currentIndex];
    final isLast = currentIndex == slides.length - 1;

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(top: 32.H, left: 28.W, right: 28.W, bottom: 20.H),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36.R)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Accent Pill
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: 40.W,
            height: 5.H,
            decoration: BoxDecoration(
              color: slide.accent,
              borderRadius: BorderRadius.circular(99.R),
            ),
          ),
          20.vS,

          // Text Content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: Column(
              key: ValueKey(currentIndex),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slide.headline,
                  style: TextStyle(
                    fontSize: 28.SP,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F3D35),
                    height: 1.35,
                  ),
                ),
                12.vS,
                Text(
                  slide.body,
                  style: TextStyle(
                    fontSize: 14.5.SP,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF5A7A76),
                    height: 1.75,
                  ),
                ),
              ],
            ),
          ),

          30.vS,

          // Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slides.length, (index) {
              final active = index == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.W),
                width: active ? 28.W : 8.W,
                height: 8.H,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF1B59B2)
                      : const Color(0xFFC8D9F0),
                  borderRadius: BorderRadius.circular(99.R),
                ),
              );
            }),
          ),
          20.vS,

          // CTA Button
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: double.infinity,
            height: 60.H,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLast
                    ? [const Color(0xFFF37423), const Color(0xFFE85D0E)]
                    : [const Color(0xFF1B59B2), const Color(0xFF0D3A7A)],
              ),
              borderRadius: BorderRadius.circular(20.R),
              boxShadow: [
                BoxShadow(
                  color: (isLast
                          ? const Color(0xFFF37423)
                          : const Color(0xFF1B59B2))
                      .withValues(alpha: 0.30),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.R)),
              ),
              child: Text(
                isLast ? '✨  ابدئي الآن' : 'التالي  ←',
                style: TextStyle(
                  fontSize: 17.SP,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          16.vS,

          // Footer
          Center(
            child: GestureDetector(
              onTap: () => context.pushReplacementNamed(AppRoutes.login),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.H),
                child: Text.rich(
                  TextSpan(
                    text: 'لديكِ حساب؟ ',
                    style: TextStyle(
                      color: const Color(0xFF8AADA9),
                      fontSize: 13.SP,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
                      TextSpan(
                        text: 'سجّلي الدخول',
                        style: TextStyle(
                          color: Color(0xFF1B59B2),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          20.vS,
        ],
      ),
    );
  }
}
