import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/community/logic/qa_cubit.dart';
import 'package:tips_n_steps/feature/community/view/components/admin_reply_card.dart';
import 'package:tips_n_steps/feature/community/view/components/question_card.dart';

/// Fixes the confirmed bug where this view was a zero-arg widget that always
/// rendered an identical hardcoded question regardless of which one was
/// tapped. [questionId] is required so the routing owner
/// (`app_routes_implementation.dart`) is forced to thread `settings.arguments`
/// through instead of constructing this with no data.
class QuestionDetailView extends StatelessWidget {
  final String questionId;

  const QuestionDetailView({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QaCubit>(
      create: (_) => sl<QaCubit>()..loadQuestions(),
      child: _QuestionDetailBody(questionId: questionId),
    );
  }
}

class _QuestionDetailBody extends StatelessWidget {
  final String questionId;

  const _QuestionDetailBody({required this.questionId});

  @override
  Widget build(BuildContext context) {
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
            child: BlocBuilder<QaCubit, QaState>(
              builder: (context, state) {
                if (state.listStatus == QaListStatus.loading ||
                    state.listStatus == QaListStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.listStatus == QaListStatus.error) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.W),
                      child: Text(
                        state.listErrorMessage ?? 'تعذر تحميل السؤال',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final question = state.findById(questionId);
                if (question == null) {
                  return const Center(child: Text('تعذر العثور على السؤال'));
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.W),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuestionCard(question: question),
                      if (question.answer != null) ...[
                        8.vS,
                        // The backend answer object only carries a raw
                        // `doctorId` (no display name) — showing that GUID
                        // to the parent would be meaningless, and resolving
                        // it to a name would need an extra per-question
                        // `/users/{id}` lookup (the same N+1 tradeoff this
                        // plan already avoids for the asker's name).
                        AdminReplyCard(
                          reply: question.answer!.answerText,
                          adminName: 'فريق الأطباء',
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
