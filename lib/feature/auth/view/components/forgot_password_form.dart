import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // No password-reset endpoint exists on the backend yet — be honest
    // about that instead of faking a success state (same "not available
    // yet" treatment as booking/chatbot). Revisit once the backend adds a
    // reset-password flow.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'إعادة تعيين كلمة المرور غير متاحة حالياً، يرجى التواصل مع الدعم',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInput(
          label: 'البريد الإلكتروني',
          hint: 'أدخل بريدك الإلكتروني',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        32.vS,
        AppButton(
          text: 'إرسال الرابط',
          onPressed: _handleSubmit,
        ),
      ],
    );
  }
}
