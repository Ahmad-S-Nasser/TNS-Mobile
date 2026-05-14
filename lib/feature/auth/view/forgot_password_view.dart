import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/auth/view/components/forgot_password_form.dart';
import 'package:tips_n_steps/feature/auth/view/components/forgot_password_header.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.W),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ForgotPasswordHeader(),
            40.vS,
            const ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
