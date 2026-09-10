import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

/// Simplified: the backend only provides a flat `body` string per content
/// item, so the old structured steps/warning/prevention sections were
/// replaced with a single rendered text block.
class EmergencyTipDetailView extends StatelessWidget {
  final EmergencyTipModel tip;
  final VoidCallback onBack;

  const EmergencyTipDetailView({
    super.key,
    required this.tip,
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
              gradient: LinearGradient(colors: [tip.colorStart, tip.colorEnd]),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.R)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),
                8.hS,
                Expanded(
                  child: Text(
                    tip.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.SP,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                AppButton(
                  text: 'اتصل بالإسعاف 123',
                  onPressed: () {
                    // Generic emergency call action — numbers are the static
                    // list in EmergencyNumberModel.staticNumbers.
                  },
                ),
                24.vS,
                Text(
                  tip.body.isNotEmpty
                      ? tip.body
                      : 'لا يوجد محتوى متاح لهذه الحالة حالياً.',
                  style: TextStyle(
                      color: AppColors.gray700, fontSize: 14.SP, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
