import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/behavioral/data/model/behavioral_problem_model.dart';

class BehavioralProblemCard extends StatelessWidget {
  final BehavioralProblemModel problem;
  final VoidCallback onTap;

  const BehavioralProblemCard({
    super.key,
    required this.problem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 56.W,
                  height: 56.H,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [problem.colorStart, problem.colorEnd]),
                    borderRadius: BorderRadius.circular(16.R),
                  ),
                  child: Center(
                    child: Text(
                      problem.illustration,
                      style: TextStyle(fontSize: 28.SP),
                    ),
                  ),
                ),
                16.hS,
                Expanded(
                  child: Text(
                    problem.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.SP,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16.W, color: AppColors.gray400),
              ],
            ),
            12.vS,
            Text(
              problem.description,
              style: TextStyle(
                color: AppColors.gray600,
                fontSize: 13.SP,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
