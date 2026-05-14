import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onRegister;

  const RegisterForm({
    super.key,
    required this.onRegister,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _showPassword = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInput(
          label: 'الاسم الكامل',
          hint: 'أدخل اسمك الكامل',
          controller: _nameController,
        ),
        16.vS,
        AppInput(
          label: 'البريد الإلكتروني',
          hint: 'أدخل بريدك الإلكتروني',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        16.vS,
        AppInput(
          label: 'رقم الهاتف',
          hint: 'أدخل رقم هاتفك',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
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
        16.vS,
        AppInput(
          label: 'تأكيد كلمة المرور',
          hint: 'أعد إدخال كلمة المرور',
          controller: _confirmPasswordController,
          obscureText: true,
        ),
        32.vS,
        AppButton(
          text: 'إنشاء الحساب',
          onPressed: widget.onRegister,
        ),
      ],
    );
  }
}
