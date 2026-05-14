import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_footer.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_form.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  void _handleRegister(BuildContext context) {
    context.pushNamedAndRemoveUntil(AppRoutes.home,
        predicate: (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const RegisterHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.W),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterForm(onRegister: () => _handleRegister(context)),
                  24.vS,
                  const RegisterFooter(),
                  40.vS,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
