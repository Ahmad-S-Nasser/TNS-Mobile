import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_footer.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_form.dart';
import 'package:tips_n_steps/feature/auth/view/components/login_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Future<void> _handleLogin(
      BuildContext context, String email, String password) async {
    final success = await context.read<AuthCubit>().login(email, password);
    if (success && context.mounted) {
      context.pushNamedAndRemoveUntil(AppRoutes.home, predicate: (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null &&
          current.status != AuthStatus.authenticated,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      child: Scaffold(
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) => LoginForm(
                        isLoading: state.isSubmitting,
                        onLogin: (email, password) =>
                            _handleLogin(context, email, password),
                      ),
                    ),
                    24.vS,
                    const LoginFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
