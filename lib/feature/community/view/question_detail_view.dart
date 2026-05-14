import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';
import 'package:tips_n_steps/feature/community/view/components/admin_reply_card.dart';
import 'package:tips_n_steps/feature/community/view/components/question_card.dart';

class QuestionDetailView extends StatelessWidget {
  const QuestionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final question = QuestionModel(
      text: 'طفلي عمره 3 سنوات ولا يتكلم بطلاقة، هل هذا طبيعي؟',
      description:
          'يقول كلمات منفصلة فقط لكنه لا يستطيع تكوين جمل. هل يجب أن أقلق؟',
      author: 'منى أحمد',
      date: '15 أبريل 2026',
      status: 'answered',
      adminReply:
          'التطور اللغوي يختلف من طفل لآخر. في عمر 3 سنوات، يجب أن يكون الطفل قادراً على قول جمل بسيطة. ننصحك بزيارة أخصائي تخاطب للتقييم.',
      adminName: 'د. نورا حسن - أخصائية تنمية الطفل',
    );

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'تفاصيل السؤال',
              subtitle: 'إجابة الخبراء على استفسارك',
              showBackButton: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.W),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionCard(question: question),
                  if (question.adminReply != null) ...[
                    8.vS,
                    AdminReplyCard(
                      reply: question.adminReply!,
                      adminName: question.adminName,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
