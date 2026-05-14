import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? suffixText;
  final Widget? prefixIcon;

  const AppInput({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.SP,
            fontWeight: FontWeight.w600,
            color: AppColors.gray600,
          ),
        ),
        8.vS,
        AppTextField(
          controller: controller,
          isPassword: obscureText,
          type: keyboardType,
          hint: hint,
          prefix: prefixIcon,
          suffix: suffixText != null ? Text(suffixText!) : null,
        ),
      ],
    );
  }
}
