import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

/// Overview of a growth field's real content (skill/milestone counts).
/// The old prototype showed a fake "current status / target / progress %"
/// block — the backend has no such computed value without a specific
/// child's assessment history, so this is descoped to what the field
/// catalog actually provides.
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
            const Icon(Icons.insights, color: Colors.green),
            8.hS,
            Text('نظرة عامة',
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
                      Text('عدد المهارات',
                          style: TextStyle(
                              color: AppColors.gray600, fontSize: 12.SP)),
                      Text('${field.skillCount}',
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
                      Text('المعالم التطورية',
                          style: TextStyle(
                              color: AppColors.gray600, fontSize: 12.SP)),
                      Text('${field.milestoneCount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.SP)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.vS,
          Text(
            field.description,
            style: TextStyle(color: AppColors.gray700, fontSize: 13.SP, height: 1.4),
          ),
        ],
      ),
    );
  }
}
