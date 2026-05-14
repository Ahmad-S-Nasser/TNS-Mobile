import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ContentExpertCard extends StatelessWidget {
  final String expert;

  const ContentExpertCard({
    super.key,
    required this.expert,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: const Color(0xFF1B59B2).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(
          color: const Color(0xFF1B59B2).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56.W,
            height: 56.H,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF23A99A), Color(0xFF16665A)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                expert.substring(3, 4),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.SP,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          16.hS,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الخبير',
                style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
              ),
              Text(
                expert,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
