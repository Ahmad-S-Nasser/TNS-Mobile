import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/community/view/components/ask_question_form.dart';
import 'package:tips_n_steps/feature/community/view/components/question_guidelines_card.dart';

class AskQuestionView extends StatefulWidget {
  const AskQuestionView({super.key});

  @override
  State<AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends State<AskQuestionView> {
  bool _isSuccess = false;

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
                  AskQuestionForm(
                    onSubmit: (text, isAnonymous) {
                      setState(() {
                        _isSuccess = true;
                      });
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
