import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نسيت كلمة المرور؟',
          style: TextStyle(
            fontSize: 30.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray900,
          ),
        ),
        8.vS,
        Text(
          'أدخل بريدك الإلكتروني لتلقي رابط إعادة تعيين كلمة المرور',
          style: TextStyle(
            fontSize: 16.SP,
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }
}
