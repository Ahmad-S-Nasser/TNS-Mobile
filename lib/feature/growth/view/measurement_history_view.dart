import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/growth/view/components/measurement_history_card.dart';

class MeasurementHistoryView extends StatelessWidget {
  const MeasurementHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final measurements = [
      {
        'date': '14 أبريل 2026',
        'weight': '12.5',
        'height': '78',
        'head': '46.2',
        'trend': 'up'
      },
      {
        'date': '14 مارس 2026',
        'weight': '12.0',
        'height': '76.5',
        'head': '45.9',
        'trend': 'up'
      },
      {
        'date': '14 فبراير 2026',
        'weight': '11.6',
        'height': '75',
        'head': '45.6',
        'trend': 'same'
      },
    ];

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          const AppHeader(
            title: 'سجل القياسات',
            subtitle: 'متابعة نمو طفلك عبر الزمن',
            showBackButton: true,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.W),
              itemCount: measurements.length,
              itemBuilder: (context, index) {
                final m = measurements[index];
                return MeasurementHistoryCard(
                  measurement: m,
                  isLatest: index == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
