import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/app_loading.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_footer.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_form.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _handleLogin(BuildContext context) {
    context.pushNamedAndRemoveUntil(AppRoutes.home,
        predicate: (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const LoginHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.W),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginForm(onLogin: () => _handleLogin(context)),
                  24.vS,
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppLoading(),
    );
  }
}
