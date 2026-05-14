import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

class EmergencyTipCard extends StatelessWidget {
  final EmergencyTipModel tip;
  final VoidCallback onTap;

  const EmergencyTipCard({
    super.key,
    required this.tip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.H),
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 64.W,
              height: 64.H,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [tip.colorStart, tip.colorEnd]),
                borderRadius: BorderRadius.circular(20.R),
              ),
              child: Center(
                  child: Text(tip.illustration,
                      style: TextStyle(fontSize: 28.SP))),
            ),
            16.hS,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tip.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.SP)),
                  4.vS,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.W, vertical: 2.H),
                    decoration: BoxDecoration(
                      color: tip.severity == 'حرج'
                          ? Colors.red.shade100
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8.R),
                    ),
                    child: Text(
                      tip.severity,
                      style: TextStyle(
                        color: tip.severity == 'حرج'
                            ? Colors.red.shade700
                            : Colors.orange.shade700,
                        fontSize: 10.SP,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}
