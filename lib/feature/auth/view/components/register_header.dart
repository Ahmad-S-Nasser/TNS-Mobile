import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 54.H, left: 24.W, right: 24.W, bottom: 24.H),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.R),
          bottomRight: Radius.circular(40.R),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          Text(
            'إنشاء حساب جديد',
            style: TextStyle(
              fontSize: 30.SP,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'انضم إلينا لرعاية أفضل',
            style: TextStyle(
              fontSize: 14.SP,
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}
