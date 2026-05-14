import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'ليس لديك حساب؟ ',
          style: const TextStyle(color: AppColors.gray600),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () => context.pushNamed(AppRoutes.register),
                child: const Text(
                  'سجل الآن',
                  style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
