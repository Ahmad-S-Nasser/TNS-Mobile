import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class EmergencyDisclaimerCard extends StatelessWidget {
  const EmergencyDisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32.W),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تذكر دائماً',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16.SP,
                  ),
                ),
                8.vS,
                Text(
                  '• في الحالات الحرجة، اتصل بالإسعاف أولاً على 123',
                  style: TextStyle(color: Colors.red, fontSize: 12.SP),
                ),
                Text(
                  '• لا تنقل الطفل المصاب إلا إذا كان في خطر مباشر',
                  style: TextStyle(color: Colors.red, fontSize: 12.SP),
                ),
                Text(
                  '• ابق هادئاً وطمئن الطفل',
                  style: TextStyle(color: Colors.red, fontSize: 12.SP),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
