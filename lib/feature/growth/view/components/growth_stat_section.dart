import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

class GrowthStatSection extends StatelessWidget {
  final GrowthFieldModel field;

  const GrowthStatSection({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.R),
          border: Border.all(color: AppColors.gray200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.trending_up, color: Colors.green),
            8.hS,
            Text('نظرة عامة على التقدم',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP))
          ]),
          20.vS,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.W),
                  decoration: BoxDecoration(
                      color: field.bgColor,
                      borderRadius: BorderRadius.circular(20.R),
                      border: Border.all(
                          color: field.colorStart.withValues(alpha: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الحالة الحالية',
                          style: TextStyle(
                              color: AppColors.gray600, fontSize: 12.SP)),
                      Text(field.stats['current'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.SP)),
                    ],
                  ),
                ),
              ),
              12.hS,
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.W),
                  decoration: BoxDecoration(
                      color: field.bgColor,
                      borderRadius: BorderRadius.circular(20.R),
                      border: Border.all(
                          color: field.colorStart.withValues(alpha: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الهدف القادم',
                          style: TextStyle(
                              color: AppColors.gray600, fontSize: 12.SP)),
                      Text(field.stats['target'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.SP)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.vS,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('التقدم',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.gray800)),
              Text('${field.stats['progress']}%',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          8.vS,
          Container(
            height: 10.H,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(5.R)),
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: field.stats['progress'] / 100,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [field.colorStart, field.colorEnd]),
                      borderRadius: BorderRadius.circular(5.R))),
            ),
          ),
        ],
      ),
    );
  }
}
