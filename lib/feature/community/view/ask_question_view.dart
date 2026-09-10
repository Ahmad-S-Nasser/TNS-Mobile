import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/community/logic/qa_cubit.dart';
import 'package:tips_n_steps/feature/community/view/components/ask_question_form.dart';
import 'package:tips_n_steps/feature/community/view/components/question_guidelines_card.dart';

class AskQuestionView extends StatelessWidget {
  const AskQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QaCubit>(
      create: (_) => sl<QaCubit>()..loadCategories(),
      child: const _AskQuestionBody(),
    );
  }
}

class _AskQuestionBody extends StatefulWidget {
  const _AskQuestionBody();

  @override
  State<_AskQuestionBody> createState() => _AskQuestionBodyState();
}

class _AskQuestionBodyState extends State<_AskQuestionBody> {
  bool _isSuccess = false;

  Future<void> _handleSubmit(
    String category,
    String questionTextAr,
    bool isAnonymous,
  ) async {
    final trimmed = questionTextAr.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('يرجى كتابة سؤالك أولاً')));
      return;
    }

    final cubit = context.read<QaCubit>();
    final success = await cubit.askQuestion(
      category: category,
      questionTextAr: trimmed,
      isAnonymous: isAnonymous,
    );

    if (!mounted) return;

    if (success) {
      setState(() => _isSuccess = true);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(cubit.state.actionErrorMessage ?? 'تعذر إرسال السؤال'),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return SuccessState(
        title: 'تم إرسال سؤالك! 🕊️',
        description:
            'سؤالك الآن قيد المراجعة، وسيتم الرد عليه من قبل الخبراء في أقرب وقت ممكن.',
        actionLabel: 'العودة للمجتمع',
        onAction: () => context.pop(),
      );
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'اسألي سؤالك',
              subtitle: 'مساحة آمنة للحصول على إجابة من خبراء',
              showBackButton: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.W),
              child: Column(
                children: [
                  const QuestionGuidelinesCard(),
                  24.vS,
                  BlocBuilder<QaCubit, QaState>(
                    builder: (context, state) {
                      return AskQuestionForm(
                        categories: state.categories,
                        isSubmitting:
                            state.actionStatus == QaActionStatus.submitting,
                        onSubmit: _handleSubmit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
