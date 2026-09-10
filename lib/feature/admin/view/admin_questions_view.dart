import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/auth/role_gate.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/admin/view/components/admin_question_card.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';
import 'package:tips_n_steps/feature/community/logic/qa_cubit.dart';

class AdminQuestionsView extends StatelessWidget {
  const AdminQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Doctor/Admin-only screen. Gated off the single `role` string claim
    // from AuthCubit (already provided app-wide from main.dart), per the
    // rebuild plan's role_gate.dart convention.
    final role = context.watch<AuthCubit>().state.role;
    if (!isDoctorOrAdmin(role)) {
      return const _AccessDeniedView();
    }

    return BlocProvider<QaCubit>(
      create: (_) => sl<QaCubit>()..loadQuestions(),
      child: const _AdminQuestionsBody(),
    );
  }
}

class _AccessDeniedView extends StatelessWidget {
  const _AccessDeniedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
            title: 'إدارة الأسئلة',
            subtitle: 'واجهة إدارة استفسارات الأمهات',
            showBackButton: true,
          ),
          Expanded(
            child: EmptyState(
              emoji: '🔒',
              title: 'الوصول مقيد',
              description: 'هذه الصفحة متاحة لفريق الأطباء والإدارة فقط',
              actionLabel: 'رجوع',
              onAction: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminQuestionsBody extends StatelessWidget {
  const _AdminQuestionsBody();

  @override
  Widget build(BuildContext context) {
    final doctorId = context.read<AuthCubit>().state.userId ?? '';

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
            title: '[ADMIN] إدارة الأسئلة',
            subtitle: 'واجهة إدارة استفسارات الأمهات',
            showBackButton: true,
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

                final pending =
                    state.questions.where((q) => !q.isAnswered).toList();
                final answered =
                    state.questions.where((q) => q.isAnswered).toList();

                if (pending.isEmpty && answered.isEmpty) {
                  return const EmptyState(
                    emoji: '💬',
                    title: 'لا توجد أسئلة بعد',
                    description: 'ستظهر هنا أسئلة الأمهات فور إرسالها',
                  );
                }

                final cubit = context.read<QaCubit>();

                return ListView(
                  padding: EdgeInsets.all(16.W),
                  children: [
                    _buildSectionHeader('بانتظار الرد (${pending.length})'),
                    ...pending.map(
                      (q) => AdminQuestionCard(
                        question: q,
                        onReply: () =>
                            _showReplySheet(context, cubit, q, doctorId),
                      ),
                    ),
                    24.vS,
                    _buildSectionHeader('تم الرد عليها'),
                    ...answered.map((q) => AdminQuestionCard(question: q)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.H),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}

void _showReplySheet(
  BuildContext context,
  QaCubit cubit,
  QuestionModel question,
  String doctorId,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.R)),
    ),
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _ReplySheet(question: question, doctorId: doctorId),
    ),
  );
}

class _ReplySheet extends StatefulWidget {
  final QuestionModel question;
  final String doctorId;

  const _ReplySheet({required this.question, required this.doctorId});

  @override
  State<_ReplySheet> createState() => _ReplySheetState();
}

class _ReplySheetState extends State<_ReplySheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final cubit = context.read<QaCubit>();
    final success = await cubit.answerQuestion(
      questionId: widget.question.id,
      doctorId: widget.doctorId,
      answerText: text,
    );

    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(cubit.state.actionErrorMessage ?? 'تعذر إرسال الرد'),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.W,
        right: 16.W,
        top: 16.H,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.H,
      ),
      child: BlocBuilder<QaCubit, QaState>(
        builder: (context, state) {
          final isSubmitting = state.actionStatus == QaActionStatus.submitting;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الرد على السؤال',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.SP),
              ),
              8.vS,
              Text(
                widget.question.text,
                style: TextStyle(color: AppColors.gray600, fontSize: 13.SP),
              ),
              16.vS,
              AppTextField(
                controller: _controller,
                maxLine: 5,
                hint: 'اكتب ردك هنا...',
                isClickable: !isSubmitting,
              ),
              16.vS,
              AppButton(
                text: 'إرسال الرد',
                isLoading: isSubmitting,
                onPressed: _submit,
              ),
            ],
          );
        },
      ),
    );
  }
}
