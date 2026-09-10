import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/growth/logic/assessment_cubit.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_reference_card.dart';
import 'package:tips_n_steps/feature/growth/view/components/measurement_form.dart';

/// Milestone-checklist assessment flow: pick a child, resolve their age
/// group, pick a developmental field, answer its skills, submit. Replaces
/// the old weight/height/head prototype form — the backend has no physical
/// measurement endpoint, only this milestone-checklist model
/// (POST /mobile/growth/assessments).
class MeasurementView extends StatelessWidget {
  const MeasurementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssessmentCubit>(
      create: (_) => sl<AssessmentCubit>()..loadChildren(),
      child: const _MeasurementBody(),
    );
  }
}

class _MeasurementBody extends StatelessWidget {
  const _MeasurementBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
        if (state.submitStatus == AsyncStatus.loaded && state.result != null) {
          return SuccessState(
            title: 'تم تسجيل التقييم!',
            description:
                'النتيجة: ${state.result!.totalScore.toStringAsFixed(0)}% '
                '(${state.result!.scoreLevel})',
            actionLabel: 'عرض السجل',
            onAction: () => context.pushReplacementNamed(
              '/growth-fields/history',
              arguments: state.selectedChild?.id,
            ),
          );
        }

        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.gray50,
          body: Column(
            children: [
              const AppHeader(
                title: 'تسجيل تقييم جديد',
                subtitle: 'سجّل تقييم مهارات طفلك لمتابعة نموه',
                showBackButton: true,
              ),
              Expanded(child: _buildStep(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, AssessmentState state) {
    if (state.selectedChild == null) {
      return _ChildStep(state: state);
    }
    if (state.selectedField == null) {
      return _FieldStep(state: state);
    }
    return _ChecklistStep(state: state);
  }
}

class _ChildStep extends StatelessWidget {
  final AssessmentState state;

  const _ChildStep({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.childrenStatus == AsyncStatus.loading ||
        state.childrenStatus == AsyncStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.childrenStatus == AsyncStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
    }
    if (state.children.isEmpty) {
      return const Center(child: Text('يرجى إضافة طفل أولاً من صفحة الأطفال'));
    }
    return ListView(
      padding: EdgeInsets.all(16.W),
      children: [
        Text('اختر الطفل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...state.children.map((child) => Card(
              margin: EdgeInsets.only(bottom: 12.H),
              child: ListTile(
                leading: const Icon(Icons.child_care, color: AppColors.primaryBlue),
                title: Text(child.fullName),
                onTap: () => context.read<AssessmentCubit>().selectChild(child),
              ),
            )),
      ],
    );
  }
}

class _FieldStep extends StatefulWidget {
  final AssessmentState state;

  const _FieldStep({required this.state});

  @override
  State<_FieldStep> createState() => _FieldStepState();
}

class _FieldStepState extends State<_FieldStep> {
  @override
  void initState() {
    super.initState();
    if (widget.state.fieldsStatus == AsyncStatus.initial) {
      context.read<AssessmentCubit>().loadFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    if (state.fieldsStatus == AsyncStatus.loading ||
        state.fieldsStatus == AsyncStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.fieldsStatus == AsyncStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
    }

    return ListView(
      padding: EdgeInsets.all(16.W),
      children: [
        if (state.resolvedAgeGroup != null)
          Padding(
            padding: EdgeInsets.only(bottom: 12.H),
            child: Text(
              'الفئة العمرية: ${state.resolvedAgeGroup!.name}',
              style: TextStyle(color: AppColors.gray600, fontSize: 13.SP),
            ),
          ),
        Text('اختر مجال التقييم',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...state.fields.map((field) => Card(
              margin: EdgeInsets.only(bottom: 12.H),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: field.color),
                title: Text(field.title),
                subtitle: Text('${field.skillCount} مهارة'),
                onTap: () => context.read<AssessmentCubit>().selectField(field.id),
              ),
            )),
      ],
    );
  }
}

class _ChecklistStep extends StatelessWidget {
  final AssessmentState state;

  const _ChecklistStep({required this.state});

  Future<void> _handleSubmit(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<AssessmentCubit>().submit();
    if (!success && context.mounted) {
      messenger.showSnackBar(SnackBar(
        content: Text(context.read<AssessmentCubit>().state.errorMessage ??
            'تعذر حفظ التقييم'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (state.fieldDetailStatus == AsyncStatus.loading ||
        state.fieldDetailStatus == AsyncStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.fieldDetailStatus == AsyncStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
    }

    final skills = state.selectedField?.skills ?? const [];
    final isComplete = context.watch<AssessmentCubit>().isChecklistComplete;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.W),
      child: Column(
        children: [
          MeasurementForm(
            skills: skills,
            responses: state.responses,
            onBoolean: (skillId, value) =>
                context.read<AssessmentCubit>().setBooleanResponse(skillId, value),
            onNumeric: (skillId, value) =>
                context.read<AssessmentCubit>().setNumericResponse(skillId, value),
            isComplete: isComplete,
            isSubmitting: state.submitStatus == AsyncStatus.loading,
            onSubmit: () => _handleSubmit(context),
          ),
          16.vS,
          const GrowthReferenceCard(),
          40.vS,
        ],
      ),
    );
  }
}
