import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class MeasurementHistoryCard extends StatelessWidget {
  final Map<String, String> measurement;
  final bool isLatest;

  const MeasurementHistoryCard({
    super.key,
    required this.measurement,
    this.isLatest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.W, vertical: 12.H),
            decoration: BoxDecoration(
              color: isLatest
                  ? AppColors.primaryBlue.withValues(alpha: 0.06)
                  : AppColors.gray50,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.R),
                  topRight: Radius.circular(24.R)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  measurement['date']!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          isLatest ? AppColors.primaryBlue : AppColors.gray600),
                ),
                if (isLatest)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.W, vertical: 4.H),
                    decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(20.R)),
                    child: Text(
                      'الأحدث',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.SP,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.W),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHistoryMetric('الوزن', measurement['weight']!, 'كجم',
                    measurement['trend']!),
                _buildHistoryMetric(
                    'الطول', measurement['height']!, 'سم', 'up'),
                _buildHistoryMetric(
                    'م. الرأس', measurement['head']!, 'سم', 'same'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryMetric(
      String label, String value, String unit, String trend) {
    return Column(
      children: [
        Icon(
            trend == 'up'
                ? Icons.trending_up
                : trend == 'down'
                    ? Icons.trending_down
                    : Icons.remove,
            color: trend == 'up'
                ? Colors.green
                : trend == 'down'
                    ? Colors.red
                    : Colors.grey,
            size: 20.W),
        4.vS,
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.SP,
                  color: AppColors.gray800)),
          TextSpan(
              text: ' $unit',
              style: TextStyle(fontSize: 12.SP, color: AppColors.gray500))
        ])),
        Text(label,
            style: TextStyle(fontSize: 12.SP, color: AppColors.gray500)),
      ],
    );
  }
}
