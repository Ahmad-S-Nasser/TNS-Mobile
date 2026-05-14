import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/behavioral/data/model/behavioral_problem_model.dart';

class BehavioralDetailView extends StatelessWidget {
  final BehavioralProblemModel problem;
  final VoidCallback onBack;

  const BehavioralDetailView({
    super.key,
    required this.problem,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.H, bottom: 24.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [problem.colorStart, problem.colorEnd]),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.R),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),
                8.hS,
                Text(
                  problem.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.SP,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                Text(
                  problem.description,
                  style: TextStyle(
                      fontSize: 16.SP, height: 1.6, color: AppColors.gray800),
                ),
                24.vS,
                _buildSection(
                    'الأسباب المحتملة', problem.causes, Colors.orange),
                24.vS,
                _buildSection('نصائح للتعامل', problem.solutions, Colors.green),
                24.vS,
                _buildExpertSection(problem.expertTips),
                40.vS,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.SP, color: color),
        ),
        12.vS,
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 8.H),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ',
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.SP)),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                          fontSize: 14.SP,
                          height: 1.5,
                          color: AppColors.gray700),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildExpertSection(List<String> tips) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: const Color(0xFF23A99A).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.R),
        border:
            Border.all(color: const Color(0xFF23A99A).withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Color(0xFF16665A)),
              8.hS,
              Text(
                'نصائح الخبراء',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF16665A),
                  fontSize: 16.SP,
                ),
              )
            ],
          ),
          12.vS,
          ...tips.map((tip) => Padding(
                padding: EdgeInsets.only(bottom: 8.H),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check,
                        size: 16.W, color: const Color(0xFF16665A)),
                    8.hS,
                    Expanded(
                      child: Text(
                        tip,
                        style: TextStyle(
                            fontSize: 13.SP, color: const Color(0xFF16665A)),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
