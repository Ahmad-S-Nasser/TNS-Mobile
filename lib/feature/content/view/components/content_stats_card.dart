import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ContentStatsCard extends StatelessWidget {
  final int availableCount;
  final int savedCount;

  const ContentStatsCard({
    super.key,
    required this.availableCount,
    required this.savedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: const Color(0xFF23A99A).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.R),
        border:
            Border.all(color: const Color(0xFF23A99A).withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
              availableCount.toString(), 'محتوى متاح', const Color(0xFF1B59B2)),
          _buildStatItem(
              savedCount.toString(), 'محفوظ', const Color(0xFFF37423)),
          _buildStatItem('12+', 'خبير', const Color(0xFF82CD47)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 24.SP, fontWeight: FontWeight.bold, color: color)),
        Text(label,
            style: TextStyle(fontSize: 10.SP, color: AppColors.gray600)),
      ],
    );
  }
}
