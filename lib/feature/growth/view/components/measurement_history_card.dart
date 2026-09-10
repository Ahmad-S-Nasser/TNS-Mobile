import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/assessment_model.dart';

class MeasurementHistoryCard extends StatelessWidget {
  final AssessmentHistoryEntry entry;
  final bool isLatest;

  const MeasurementHistoryCard({
    super.key,
    required this.entry,
    this.isLatest = false,
  });

  String get _formattedDate {
    final date = entry.completedAt;
    if (date == null) return '—';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

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
                  _formattedDate,
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
                Column(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber.shade700, size: 22.W),
                    4.vS,
                    Text('${entry.totalScore.toStringAsFixed(0)}%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.SP,
                            color: AppColors.gray800)),
                    Text('النتيجة الإجمالية',
                        style: TextStyle(fontSize: 12.SP, color: AppColors.gray500)),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.stars, color: AppColors.primaryBlue),
                    4.vS,
                    Text(entry.scoreLevel,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.SP,
                            color: AppColors.gray800)),
                    Text('المستوى',
                        style: TextStyle(fontSize: 12.SP, color: AppColors.gray500)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
