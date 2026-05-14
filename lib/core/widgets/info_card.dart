import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_card.dart';

enum InfoCardVariant { primary, success, warning }

class InfoCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final InfoCardVariant variant;

  const InfoCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    this.variant = InfoCardVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color titleColor;

    switch (variant) {
      case InfoCardVariant.success:
        bgColor = AppColors.successGreen.withValues(alpha: 0.06);
        borderColor = AppColors.successGreen.withValues(alpha: 0.15);
        titleColor = AppColors.successGreen;
        break;
      case InfoCardVariant.warning:
        bgColor = AppColors.orange.withValues(alpha: 0.06);
        borderColor = AppColors.orange.withValues(alpha: 0.15);
        titleColor = AppColors.orange;
        break;
      case InfoCardVariant.primary:
        bgColor = AppColors.primaryBlue.withValues(alpha: 0.06);
        borderColor = AppColors.primaryBlue.withValues(alpha: 0.15);
        titleColor = AppColors.primaryBlue;
    }

    return AppCard(
      color: bgColor,
      border: Border.all(color: borderColor, width: 2.W),
      padding: EdgeInsets.all(16.W),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 24.SP)),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.SP,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                4.vS,
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.SP,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
  }
}
