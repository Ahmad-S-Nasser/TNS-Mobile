import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class HomeChildrenQuickAccess extends StatelessWidget {
  const HomeChildrenQuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.W),
      child: GestureDetector(
        onTap: () => context.pushNamed('/children'),
        child: Container(
          padding: EdgeInsets.all(20.W),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(24.R),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('👶', style: TextStyle(fontSize: 40.SP)),
                  16.hS,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أطفالي',
                        style: TextStyle(
                            fontSize: 18.SP,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'عرض وإدارة معلومات الأطفال',
                        style:
                            TextStyle(fontSize: 14.SP, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.W),
            ],
          ),
        ),
      ),
    );
  }
}
