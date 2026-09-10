import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class GrowthReferenceCard extends StatelessWidget {
  const GrowthReferenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Text('💡', style: TextStyle(fontSize: 24.SP)),
          12.hS,
          Expanded(
            child: Text(
              'أجيبي بصدق عن كل مهارة بناءً على قدرات طفلك الحالية — النتيجة تساعدك على متابعة تطوره بدقة',
              style: TextStyle(fontSize: 13.SP, color: AppColors.primaryBlue),
            ),
          ),
        ],
      ),
    );
  }
}
