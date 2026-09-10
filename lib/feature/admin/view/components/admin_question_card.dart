import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';

class AdminQuestionCard extends StatelessWidget {
  final QuestionModel question;
  final VoidCallback? onReply;

  const AdminQuestionCard({
    super.key,
    required this.question,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final isAnswered = question.isAnswered;

    return Container(
      margin: EdgeInsets.only(bottom: 12.H),
      padding: EdgeInsets.all(16.W),
      decoration: BoxDecoration(
        color: isAnswered ? AppColors.gray50 : Colors.white,
        borderRadius: BorderRadius.circular(16.R),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                question.displayAuthor,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.SP),
              ),
              const Spacer(),
              Text(
                question.displayDate,
                style: TextStyle(color: AppColors.gray500, fontSize: 10.SP),
              ),
            ],
          ),
          4.vS,
          Text(question.text, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (isAnswered && question.answer != null) ...[
            8.vS,
            Text(
              question.answer!.answerText,
              style: TextStyle(color: AppColors.gray700, fontSize: 12.SP),
            ),
          ],
          if (!isAnswered) ...[
            8.vS,
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: onReply,
                child: Text(
                  'إضافة رد',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 12.SP,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
