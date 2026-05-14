import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';

class EmptyState extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.H),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: 80.SP)),
            24.vS,
            Text(
              title,
              style: TextStyle(
                fontSize: 24.SP,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800,
              ),
            ),
            12.vS,
            Text(
              description,
              style: TextStyle(fontSize: 18.SP, color: AppColors.gray500),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              32.vS,
              AppButton(
                text: actionLabel!,
                onPressed: onAction!,
                width: 200.W,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
