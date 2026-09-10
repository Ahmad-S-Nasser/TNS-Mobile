import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await context.read<AuthCubit>().logout();
    if (context.mounted) {
      context.pushNamedAndRemoveUntil(AppRoutes.login,
          predicate: (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _handleLogout(context),
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
