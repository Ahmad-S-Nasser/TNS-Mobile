import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'لديك حساب بالفعل؟ ',
          style: const TextStyle(color: AppColors.gray600),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () => context.pushReplacementNamed(AppRoutes.login),
                child: const Text(
                  'سجل دخولك',
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
