import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class GrowthMetricsSection extends StatelessWidget {
  final List<Map<String, dynamic>> metrics;

  const GrowthMetricsSection({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المقاييس التفصيلية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...metrics.map((metric) => Container(
              margin: EdgeInsets.only(bottom: 12.H),
              padding: EdgeInsets.all(16.W),
              decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(20.R)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(metric['label'],
                            style: TextStyle(
                                color: AppColors.gray600, fontSize: 12.SP)),
                        Text(metric['value'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.SP)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.W, vertical: 4.H),
                        decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12.R)),
                        child: Text(metric['status'],
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.SP)),
                      ),
                      if (metric['trend'] != 'ثابت')
                        Text('↑ ${metric['trend']}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 10.SP,
                                fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
