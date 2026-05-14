import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

class GrowthTipsSection extends StatelessWidget {
  final GrowthFieldModel field;

  const GrowthTipsSection({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
          color: field.bgColor,
          borderRadius: BorderRadius.circular(24.R),
          border: Border.all(color: field.colorStart.withValues(alpha: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('💡', style: TextStyle(fontSize: 24.SP)),
            12.hS,
            Text('نصائح لتعزيز النمو',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP))
          ]),
          16.vS,
          ...field.tips.map((tip) => Padding(
                padding: EdgeInsets.only(bottom: 12.H),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.SP)),
                    Expanded(
                        child: Text(tip,
                            style: TextStyle(
                                color: AppColors.gray700,
                                height: 1.4,
                                fontSize: 14.SP))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
