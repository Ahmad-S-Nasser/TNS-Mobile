import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/growth/logic/assessment_cubit.dart';
import 'package:tips_n_steps/feature/growth/view/components/measurement_history_card.dart';

class MeasurementHistoryView extends StatelessWidget {
  /// Optional — if not provided (e.g. reached directly from the growth
  /// fields screen rather than right after submitting an assessment), the
  /// user picks a child first.
  final String? childId;

  const MeasurementHistoryView({super.key, this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssessmentCubit>(
      create: (_) {
        final cubit = sl<AssessmentCubit>();
        if (childId != null) {
          cubit.loadHistory(childId!);
        } else {
          cubit.loadChildren();
        }
        return cubit;
      },
      child: _MeasurementHistoryBody(hasPresetChild: childId != null),
    );
  }
}

class _MeasurementHistoryBody extends StatelessWidget {
  final bool hasPresetChild;

  const _MeasurementHistoryBody({required this.hasPresetChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          const AppHeader(
            title: 'سجل التقييمات',
            subtitle: 'متابعة نمو طفلك عبر الزمن',
            showBackButton: true,
          ),
          Expanded(
            child: BlocBuilder<AssessmentCubit, AssessmentState>(
              builder: (context, state) {
                if (!hasPresetChild && state.selectedChild == null) {
                  return _buildChildPicker(context, state);
                }
                return _buildHistory(context, state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildPicker(BuildContext context, AssessmentState state) {
    if (state.childrenStatus == AsyncStatus.loading ||
        state.childrenStatus == AsyncStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.children.isEmpty) {
      return const Center(child: Text('لا يوجد أطفال مسجلون بعد'));
    }
    return ListView(
      padding: EdgeInsets.all(16.W),
      children: state.children
          .map((child) => Card(
                margin: EdgeInsets.only(bottom: 12.H),
                child: ListTile(
                  leading:
                      const Icon(Icons.child_care, color: AppColors.primaryBlue),
                  title: Text(child.fullName),
                  onTap: () {
                    context.read<AssessmentCubit>().selectChild(child);
                    context.read<AssessmentCubit>().loadHistory(child.id);
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _buildHistory(BuildContext context, AssessmentState state) {
    if (state.historyStatus == AsyncStatus.loading ||
        state.historyStatus == AsyncStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.historyStatus == AsyncStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
    }
    if (state.history.isEmpty) {
      return const Center(child: Text('لا توجد تقييمات مسجلة بعد'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.W),
      itemCount: state.history.length,
      itemBuilder: (context, index) {
        return MeasurementHistoryCard(
          entry: state.history[index],
          isLatest: index == 0,
        );
      },
    );
  }
}
