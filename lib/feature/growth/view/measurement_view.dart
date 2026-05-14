import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_reference_card.dart';
import 'package:tips_n_steps/feature/growth/view/components/measurement_form.dart';

class MeasurementView extends StatefulWidget {
  const MeasurementView({super.key});

  @override
  State<MeasurementView> createState() => _MeasurementViewState();
}

class _MeasurementViewState extends State<MeasurementView> {
  bool _isSubmitted = false;

  void _handleSubmit(Map<String, String> data) {
    // Logic to save data here
    setState(() => _isSubmitted = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return SuccessState(
        title: 'تم تسجيل القياس!',
        description:
            'تم حفظ قياسات طفلك بنجاح. يمكنك متابعة تطوره من سجل القياسات.',
        actionLabel: 'عرض السجل',
        onAction: () => context.pushReplacementNamed('/growth-fields/history'),
      );
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          const AppHeader(
            title: 'تسجيل قياس جديد',
            subtitle: 'سجّل قياسات طفلك لمتابعة نموه',
            showBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.W),
              child: Column(
                children: [
                  MeasurementForm(onSubmit: _handleSubmit),
                  16.vS,
                  const GrowthReferenceCard(),
                  40.vS,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
