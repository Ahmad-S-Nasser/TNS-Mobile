import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class GrowthMilestonesSection extends StatelessWidget {
  final List<Map<String, dynamic>> milestones;

  const GrowthMilestonesSection({
    super.key,
    required this.milestones,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المعالم التطورية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...milestones.map((milestone) => Container(
              margin: EdgeInsets.only(bottom: 12.H),
              padding: EdgeInsets.all(16.W),
              decoration: BoxDecoration(
                color: milestone['achieved']
                    ? Colors.green.shade50
                    : AppColors.gray50,
                borderRadius: BorderRadius.circular(20.R),
                border: Border.all(
                    color: milestone['achieved']
                        ? Colors.green.shade100
                        : Colors.transparent),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.W,
                    height: 40.H,
                    decoration: BoxDecoration(
                        color: milestone['achieved']
                            ? Colors.green
                            : AppColors.gray300,
                        shape: BoxShape.circle),
                    child: Center(
                        child: Icon(
                            milestone['achieved']
                                ? Icons.check
                                : Icons.radio_button_unchecked,
                            color: Colors.white,
                            size: 20.W)),
                  ),
                  16.hS,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(milestone['age'],
                            style: TextStyle(
                                color: milestone['achieved']
                                    ? Colors.green
                                    : AppColors.gray500,
                                fontSize: 12.SP,
                                fontWeight: FontWeight.bold)),
                        Text(milestone['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.SP)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
