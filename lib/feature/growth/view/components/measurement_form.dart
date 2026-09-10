import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/feature/growth/data/model/assessment_model.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

/// A per-skill milestone checklist — one input control per skill, matched
/// to that skill's real `metricType` (Boolean/Numeric/Scale). This replaced
/// the old weight/height/head prototype form: the backend has no physical
/// measurement endpoint, only this milestone-checklist model.
class MeasurementForm extends StatelessWidget {
  final List<GrowthSkillModel> skills;
  final Map<String, SkillResponseInput> responses;
  final void Function(String skillId, bool value) onBoolean;
  final void Function(String skillId, double value) onNumeric;
  final bool isComplete;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const MeasurementForm({
    super.key,
    required this.skills,
    required this.responses,
    required this.onBoolean,
    required this.onNumeric,
    required this.isComplete,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...skills.map((skill) => _SkillTile(
              skill: skill,
              response: responses[skill.id],
              onBoolean: (v) => onBoolean(skill.id, v),
              onNumeric: (v) => onNumeric(skill.id, v),
            )),
        24.vS,
        AppButton(
          text: '💾  حفظ التقييم',
          isLoading: isSubmitting,
          onPressed: isComplete ? onSubmit : null,
        ),
        if (!isComplete) ...[
          8.vS,
          Text(
            'يرجى الإجابة عن جميع المهارات أعلاه للمتابعة',
            style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class _SkillTile extends StatelessWidget {
  final GrowthSkillModel skill;
  final SkillResponseInput? response;
  final void Function(bool value) onBoolean;
  final void Function(double value) onNumeric;

  const _SkillTile({
    required this.skill,
    required this.response,
    required this.onBoolean,
    required this.onNumeric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.R),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill.titleAr,
              style: TextStyle(fontSize: 16.SP, fontWeight: FontWeight.bold)),
          if (skill.descriptionAr.isNotEmpty) ...[
            4.vS,
            Text(skill.descriptionAr,
                style: TextStyle(color: AppColors.gray500, fontSize: 12.SP)),
          ],
          16.vS,
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    switch (skill.metricType) {
      case GrowthMetricType.boolean:
        return Row(
          children: [
            Expanded(
              child: _choiceChip(
                label: 'نعم',
                selected: response?.yesNoValue == true,
                onTap: () => onBoolean(true),
              ),
            ),
            12.hS,
            Expanded(
              child: _choiceChip(
                label: 'لا',
                selected: response?.yesNoValue == false,
                onTap: () => onBoolean(false),
              ),
            ),
          ],
        );
      case GrowthMetricType.scale:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (i) {
            final selected = response?.numericValue == i.toDouble();
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.W),
                child: _choiceChip(
                  label: '$i',
                  selected: selected,
                  onTap: () => onNumeric(i.toDouble()),
                ),
              ),
            );
          }),
        );
      case GrowthMetricType.numeric:
      case GrowthMetricType.unknown:
        return TextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: skill.unit != null ? 'القيمة (${skill.unit})' : 'القيمة',
            suffixText: skill.unit,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.R)),
          ),
          controller: TextEditingController(
            text: response?.numericValue?.toString() ?? '',
          ),
          onChanged: (value) {
            final parsed = double.tryParse(value);
            if (parsed != null) onNumeric(parsed);
          },
        );
    }
  }

  Widget _choiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.H),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : AppColors.gray50,
          borderRadius: BorderRadius.circular(14.R),
          border: Border.all(
              color: selected ? AppColors.primaryBlue : AppColors.gray200),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.gray700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
