import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';

class MeasurementForm extends StatefulWidget {
  final Function(Map<String, String> data) onSubmit;

  const MeasurementForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _headController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _handleSubmit() {
    widget.onSubmit({
      'weight': _weightController.text,
      'height': _heightController.text,
      'head': _headController.text,
      'notes': _notesController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionCard('📅  تاريخ القياس', [
          const AppInput(
              label: 'التاريخ', keyboardType: TextInputType.datetime),
        ]),
        16.vS,
        _buildSectionCard('📏  القياسات الجسدية', [
          AppInput(
              label: 'الوزن (كجم)',
              hint: 'مثال: 12.5',
              controller: _weightController,
              keyboardType: TextInputType.number,
              suffixText: 'كجم'),
          16.vS,
          AppInput(
              label: 'الطول (سم)',
              hint: 'مثال: 78',
              controller: _heightController,
              keyboardType: TextInputType.number,
              suffixText: 'سم'),
          16.vS,
          AppInput(
              label: 'محيط الرأس (سم)',
              hint: 'مثال: 46',
              controller: _headController,
              keyboardType: TextInputType.number,
              suffixText: 'سم'),
        ]),
        16.vS,
        _buildSectionCard('📝  ملاحظات (اختياري)', [
          AppTextField(
            controller: _notesController,
            maxLine: 3,
            hint: 'أي ملاحظات إضافية عن صحة الطفل...',
          ),
        ]),
        32.vS,
        AppButton(
          text: '💾  حفظ القياس',
          onPressed: _handleSubmit,
        ),
      ],
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.R),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 18.SP,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray800)),
          20.vS,
          ...children,
        ],
      ),
    );
  }
}
