import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final VoidCallback? onTap;

  const QuestionCard({
    super.key,
    required this.question,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.gray100,
                child: Icon(Icons.person, color: AppColors.gray400),
              ),
              12.hS,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.author,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    question.date,
                    style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.W, vertical: 4.H),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.R),
                ),
                child: Text(
                  question.status == 'answered' ? 'مجاب' : 'قيد الانتظار',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.SP,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          16.vS,
          Text(
            question.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.SP,
              height: 1.4,
            ),
          ),
          if (question.description != null) ...[
            8.vS,
            Text(
              question.description!,
              style: TextStyle(
                color: AppColors.gray700,
                height: 1.4,
                fontSize: 14.SP,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
