import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class RegisterForm extends StatefulWidget {
  /// Backend register body only accepts email/password/firstName/lastName
  /// (no phone at registration time — phone is set later via profile
  /// update), so the phone field here is currently decorative/local-only.
  final void Function({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) onRegister;
  final bool isLoading;

  const RegisterForm({
    super.key,
    required this.onRegister,
    this.isLoading = false,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _showPassword = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة جميع الحقول المطلوبة')),
      );
      return;
    }
    if (password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    widget.onRegister(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInput(
          label: 'الاسم الأول',
          hint: 'أدخل اسمك الأول',
          controller: _firstNameController,
        ),
        16.vS,
        AppInput(
          label: 'اسم العائلة',
          hint: 'أدخل اسم العائلة',
          controller: _lastNameController,
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
          isLoading: widget.isLoading,
          onPressed: _handleSubmit,
        ),
      ],
    );
  }
}
