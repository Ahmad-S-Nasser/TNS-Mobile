import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLogin,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInput(
          label: 'البريد الإلكتروني',
          hint: 'أدخل بريدك الإلكتروني',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        16.vS,
        AppInput(
          label: 'كلمة المرور',
          hint: 'أدخل كلمة المرور',
          controller: _passwordController,
          obscureText: !_showPassword,
          prefixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _showPassword = !_showPassword),
          ),
        ),
        12.vS,
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => context.pushNamed(AppRoutes.forgotPassword),
            child: const Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(
                  color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        24.vS,
        AppButton(
          text: 'تسجيل الدخول',
          isLoading: widget.isLoading,
          onPressed: () => widget.onLogin(
            _emailController.text.trim(),
            _passwordController.text,
          ),
        ),
      ],
    );
  }
}
