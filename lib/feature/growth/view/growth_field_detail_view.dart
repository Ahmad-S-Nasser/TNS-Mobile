import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_metrics_section.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_milestones_section.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_stat_section.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_tips_section.dart';

class GrowthFieldDetailView extends StatelessWidget {
  final GrowthFieldModel field;
  final VoidCallback onBack;

  const GrowthFieldDetailView({
    super.key,
    required this.field,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.H, bottom: 20.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [field.colorStart, field.colorEnd]),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.R)),
              boxShadow: [
                BoxShadow(
                    color: field.colorEnd.withValues(alpha: 0.3),
                    blurRadius: 15)
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: onBack),
                    8.hS,
                    Text(field.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.SP)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                GrowthStatSection(field: field),
                24.vS,
                GrowthMetricsSection(metrics: field.metrics),
                24.vS,
                GrowthMilestonesSection(milestones: field.milestones),
                24.vS,
                GrowthTipsSection(field: field),
                32.vS,
                Row(
                  children: [
                    Expanded(
                        child: AppButton(
                            text: 'تسجيل قياس',
                            onPressed: () =>
                                context.pushNamed('/growth-fields/measure'))),
                    12.hS,
                    Expanded(
                        child: AppButton(
                      text: 'عرض السجل',
                      onPressed: () =>
                          context.pushNamed('/growth-fields/history'),
                    )),
                  ],
                ),
                12.vS,
                AppButton(
                    text: 'حجز استشارة مع طبيب',
                    onPressed: () => context.pushNamed('/booking')),
                40.vS,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
