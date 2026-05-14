import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class CommunityHeaderIcon extends StatelessWidget {
  const CommunityHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.H,
      left: 16.W,
      child: GestureDetector(
        onTap: () => context.pushNamed('/community'),
        child: Container(
          width: 44.W,
          height: 44.H,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(16.R),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.4), width: 1.5.W),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.community,
              width: 24.W,
              height: 24.H,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
