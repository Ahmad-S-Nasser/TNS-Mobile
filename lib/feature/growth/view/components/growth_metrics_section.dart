import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

/// Lists the field's skills and how each is measured. The old prototype
/// showed fabricated live values/trends here — those don't exist without a
/// specific child's assessment, so this shows the real, static metadata
/// (metric type + unit) instead.
class GrowthMetricsSection extends StatelessWidget {
  final List<GrowthSkillModel> skills;

  const GrowthMetricsSection({
    super.key,
    required this.skills,
  });

  String _metricLabel(GrowthSkillModel skill) {
    switch (skill.metricType) {
      case GrowthMetricType.boolean:
        return 'نعم / لا';
      case GrowthMetricType.numeric:
        return skill.unit != null ? 'رقمي (${skill.unit})' : 'رقمي';
      case GrowthMetricType.scale:
        return 'تقييم من 0 إلى 4';
      case GrowthMetricType.unknown:
        return '—';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المهارات المقيّمة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...skills.map((skill) => Container(
              margin: EdgeInsets.only(bottom: 12.H),
              padding: EdgeInsets.all(16.W),
              decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(20.R)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(skill.titleAr,
                            style: TextStyle(
                                color: AppColors.gray800,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.SP)),
                        if (skill.descriptionAr.isNotEmpty)
                          Text(skill.descriptionAr,
                              style: TextStyle(
                                  color: AppColors.gray500, fontSize: 12.SP)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.W, vertical: 4.H),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12.R)),
                    child: Text(_metricLabel(skill),
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.SP)),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
