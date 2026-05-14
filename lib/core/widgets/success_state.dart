import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';

class SuccessState extends StatelessWidget {
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  const SuccessState({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.W),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.W,
                height: 100.H,
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle,
                    color: AppColors.successGreen, size: 64.SP),
              ),
              32.vS,
              Text(
                title,
                style: TextStyle(
                    fontSize: 24.SP,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800),
                textAlign: TextAlign.center,
              ),
              16.vS,
              Text(
                description,
                style: TextStyle(
                    fontSize: 16.SP, color: AppColors.gray500, height: 1.6),
                textAlign: TextAlign.center,
              ),
              48.vS,
              AppButton(
                text: actionLabel,
                onPressed: onAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
