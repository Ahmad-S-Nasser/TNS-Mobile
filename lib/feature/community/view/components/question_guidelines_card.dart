import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class QuestionGuidelinesCard extends StatelessWidget {
  const QuestionGuidelinesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16.R),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield, color: Colors.blue),
          12.hS,
          Expanded(
            child: Text(
              'جميع الأسئلة تراجع بعناية من فريقنا المتخصص نضمن لك بيئة آمنة',
              style: TextStyle(fontSize: 12.SP, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
