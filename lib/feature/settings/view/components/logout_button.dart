import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => context.pushNamedAndRemoveUntil(AppRoutes.login,
          predicate: (route) => false),
      icon: const Icon(Icons.logout, color: Colors.red),
      label: Text(
        'تسجيل الخروج',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16.SP,
        ),
      ),
    );
  }
}
