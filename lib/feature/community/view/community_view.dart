import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';
import 'package:tips_n_steps/feature/community/view/components/ask_question_button.dart';
import 'package:tips_n_steps/feature/community/view/components/question_card.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<QuestionModel> questions = [
      QuestionModel(
          text: 'طفلي عمره 3 سنوات ولا يتكلم بطلاقة، هل هذا طبيعي؟',
          author: 'منى أحمد',
          date: 'منذ ساعتين',
          status: 'answered'),
      QuestionModel(
          text: 'كيف أتعامل مع نوبات الغضب المتكررة لطفلي؟',
          author: 'أم مجهولة',
          date: 'منذ 4 ساعات',
          status: 'answered'),
    ];

    return AppLayout(
      currentRoute: '/community',
      title: 'مجتمع الأمهات',
      subtitle: 'مساحة آمنة لطرح الأسئلة والحصول على إجابات',
      useScrollContainer: false,
      body: Column(
        children: [
          AskQuestionButton(
            onTap: () => context.pushNamed('/community/ask'),
          ),
          Expanded(
            child: questions.isEmpty
                ? EmptyState(
                    emoji: '💬',
                    title: 'لا توجد أسئلة بعد',
                    description: 'كوني أول من يطرح سؤالاً في المجتمع',
                    actionLabel: 'اسألي سؤالك',
                    onAction: () => context.pushNamed('/community/ask'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.W),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return QuestionCard(
                        question: question,
                        onTap: () =>
                            context.pushNamed(AppRoutes.questionDetail),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
