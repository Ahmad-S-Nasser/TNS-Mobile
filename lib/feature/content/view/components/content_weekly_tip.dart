import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class ContentWeeklyTip extends StatelessWidget {
  const ContentWeeklyTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: const Color(0xFFF37423).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(24.R),
        border:
            Border.all(color: const Color(0xFFF37423).withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡', style: TextStyle(fontSize: 24.SP)),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'محتوى جديد أسبوعياً',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFFc45a0a)),
                ),
                Text(
                  'نضيف مقالات وفيديوهات جديدة كل أسبوع من خبراء متخصصين',
                  style: TextStyle(
                      fontSize: 12.SP, color: const Color(0xFFa34e0a)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
