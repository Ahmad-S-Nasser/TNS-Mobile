import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class SplashFooter extends StatelessWidget {
  final AnimationController entryController;
  final Animation<double> footerFadeUp;

  const SplashFooter({
    super.key,
    required this.entryController,
    required this.footerFadeUp,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: entryController,
      builder: (context, child) {
        final fadeValue = footerFadeUp.value;
        final slideOffset = (1.0 - fadeValue) * 20.0;

        return Opacity(
          opacity: fadeValue,
          child: Transform.translate(
            offset: Offset(0, slideOffset),
            child: Column(
              children: [
                // Three-dot loader
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.5.W),
                      child: _buildDot(index),
                    );
                  }),
                ),

                18.vS,

                // Sub-brand line
                Text(
                  'NURTURE · GUIDE · GROW',
                  style: TextStyle(
                    fontSize: 10.5.SP,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.32),
                    letterSpacing: 2,
                  ),
                ),

                8.vS,

                // Haya Karima Footer Branding
                _buildBrandingFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDot(int index) {
    // Sequential pop animation for dots
    final start = 0.5 + (index * 0.05);
    final popValue = CurvedAnimation(
      parent: entryController,
      curve: Interval(start, start + 0.2, curve: Curves.easeOutBack),
    ).value;

    final isMain = index == 1;
    final size = (isMain ? 10.W : 7.W) * popValue;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isMain ? AppColors.orange : Colors.white.withValues(alpha: 0.45),
        shape: BoxShape.circle,
        boxShadow: isMain
            ? [
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.65),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildBrandingFooter() {
    return Column(
      children: [
        // Thin divider
        Container(
          width: 48.W,
          height: 1.H,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(99.R),
          ),
        ),
        8.vS,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Powered by ',
              style: TextStyle(
                fontSize: 10.SP,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.38),
                letterSpacing: 0.4,
              ),
            ),
            7.hS,
            // Haya Karima logo pill
            Container(
              padding: EdgeInsets.fromLTRB(5.W, 3.H, 8.W, 3.H),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20.R),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.hayahLogo,
                    height: 18.H,
                    opacity: const AlwaysStoppedAnimation(0.88),
                  ),
                  5.hS,
                  Text(
                    'Haya Karima',
                    style: TextStyle(
                      fontSize: 10.SP,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.70),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
