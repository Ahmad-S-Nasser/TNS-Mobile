import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.W, vertical: 8.H),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppImages.logo,
              height: 34.H,
              color: Colors.white.withValues(alpha: 0.92),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(99.R),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(99.R),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          context.pushReplacementNamed(AppRoutes.login),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.W, vertical: 6.H),
                        child: Row(
                          children: [
                            Text(
                              'تخطي',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.SP,
                              ),
                            ),
                            4.hS,
                            const Icon(Icons.chevron_left,
                                size: 13, color: Colors.white70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
