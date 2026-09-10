import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_footer.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_form.dart';
import 'package:tips_n_steps/feature/auth/view/components/register_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  Future<void> _handleRegister(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final success = await context.read<AuthCubit>().register(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        );
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) => RegisterForm(
                        isLoading: state.isSubmitting,
                        onRegister: ({
                          required firstName,
                          required lastName,
                          required email,
                          required password,
                        }) =>
                            _handleRegister(
                          context,
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password,
                        ),
                      ),
                    ),
                    24.vS,
                    const RegisterFooter(),
                    40.vS,
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
