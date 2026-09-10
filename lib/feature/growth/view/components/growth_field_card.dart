import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

class GrowthFieldCard extends StatelessWidget {
  final GrowthFieldModel field;
  final VoidCallback onTap;

  const GrowthFieldCard({
    super.key,
    required this.field,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.R),
        border: Border.all(color: AppColors.gray200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.R),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.W),
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [field.colorStart, field.colorEnd]),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.R)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50.W,
                    height: 50.H,
                    decoration: BoxDecoration(
                        color: field.bgColor,
                        borderRadius: BorderRadius.circular(15.R)),
                    child: const Center(child: Icon(Icons.child_care)),
                  ),
                  16.hS,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(field.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.SP)),
                        Text(field.description,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12.SP)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.W),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.W),
                          decoration: BoxDecoration(
                              color: AppColors.gray50,
                              borderRadius: BorderRadius.circular(16.R)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('عدد المهارات',
                                  style: TextStyle(
                                      color: AppColors.gray500,
                                      fontSize: 10.SP)),
                              Text('${field.skillCount}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.SP)),
                            ],
                          ),
                        ),
                      ),
                      12.hS,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.W),
                          decoration: BoxDecoration(
                              color: AppColors.gray50,
                              borderRadius: BorderRadius.circular(16.R)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('المعالم التطورية',
                                  style: TextStyle(
                                      color: AppColors.gray500,
                                      fontSize: 10.SP)),
                              Text('${field.milestoneCount}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.SP)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.vS,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('عرض التفاصيل الكاملة',
                          style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.SP)),
                      4.hS,
                      Icon(Icons.arrow_forward,
                          color: AppColors.primaryBlue, size: 16.W),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
