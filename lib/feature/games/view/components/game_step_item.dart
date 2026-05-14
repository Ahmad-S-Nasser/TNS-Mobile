import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class GameStepItem extends StatelessWidget {
  final int number;
  final String title;
  final String desc;

  const GameStepItem({
    super.key,
    required this.number,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.H),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14.R,
            backgroundColor: AppColors.orange,
            child: Text(
              '$number',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.SP,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: TextStyle(color: AppColors.gray600, fontSize: 14.SP),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
