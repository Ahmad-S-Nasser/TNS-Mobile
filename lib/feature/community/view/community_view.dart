import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/community/logic/qa_cubit.dart';
import 'package:tips_n_steps/feature/community/view/components/ask_question_button.dart';
import 'package:tips_n_steps/feature/community/view/components/question_card.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QaCubit>(
      create: (_) => sl<QaCubit>()..loadQuestions(),
      child: const _CommunityBody(),
    );
  }
}

class _CommunityBody extends StatelessWidget {
  const _CommunityBody();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      currentRoute: '/community',
      title: 'مجتمع الأمهات',
      subtitle: 'مساحة آمنة لطرح الأسئلة والحصول على إجابات',
      useScrollContainer: false,
      body: Column(
        children: [
          AskQuestionButton(
            onTap: () => context.pushNamed(AppRoutes.askQuestion),
          ),
          Expanded(
            child: BlocBuilder<QaCubit, QaState>(
              builder: (context, state) {
                if (state.listStatus == QaListStatus.loading ||
                    state.listStatus == QaListStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.listStatus == QaListStatus.error) {
                  return EmptyState(
                    emoji: '⚠️',
                    title: 'تعذر تحميل الأسئلة',
                    description:
                        state.listErrorMessage ?? 'حدث خطأ غير متوقع',
                    actionLabel: 'إعادة المحاولة',
                    onAction: () => context.read<QaCubit>().loadQuestions(),
                  );
                }

                final questions = state.questions;
                if (questions.isEmpty) {
                  return EmptyState(
                    emoji: '💬',
                    title: 'لا توجد أسئلة بعد',
                    description: 'كوني أول من يطرح سؤالاً في المجتمع',
                    actionLabel: 'اسألي سؤالك',
                    onAction: () => context.pushNamed(AppRoutes.askQuestion),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.W),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return QuestionCard(
                      question: question,
                      onTap: () => context.pushNamed(
                        AppRoutes.questionDetail,
                        arguments: question.id,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
