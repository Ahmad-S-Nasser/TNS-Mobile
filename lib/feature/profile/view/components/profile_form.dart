import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nameController =
      TextEditingController(text: 'أحمد محمد');
  final TextEditingController _emailController =
      TextEditingController(text: 'ahmed@example.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '0123456789');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        32.vS,
        AppButton(
          text: 'حفظ التغييرات',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حفظ التغييرات بنجاح')),
            );
          },
        ),
      ],
    );
  }
}
