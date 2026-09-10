import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

/// Informational milestone timeline for a field's skills. This is a
/// browsing view (not tied to a specific child), so there is no
/// achieved/not-achieved state here — that only exists once a child has an
/// actual assessment on record (see the Measurement History screen).
class GrowthMilestonesSection extends StatelessWidget {
  final List<GrowthSkillModel> skills;

  const GrowthMilestonesSection({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final entries = <MapEntry<GrowthSkillModel, GrowthMilestoneModel>>[];
    for (final skill in skills) {
      for (final milestone in skill.milestones) {
        entries.add(MapEntry(skill, milestone));
      }
    }
    entries.sort(
        (a, b) => a.value.expectedMonth.compareTo(b.value.expectedMonth));

    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المعالم التطورية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP)),
        16.vS,
        ...entries.map((entry) => Container(
              margin: EdgeInsets.only(bottom: 12.H),
              padding: EdgeInsets.all(16.W),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(20.R),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.W,
                    height: 40.H,
                    decoration: const BoxDecoration(
                        color: AppColors.gray300, shape: BoxShape.circle),
                    child: Center(
                        child: Icon(Icons.flag, color: Colors.white, size: 18.W)),
                  ),
                  16.hS,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('عند عمر ${entry.value.expectedMonth} شهر',
                            style: TextStyle(
                                color: AppColors.gray500,
                                fontSize: 12.SP,
                                fontWeight: FontWeight.bold)),
                        Text(entry.key.titleAr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.SP)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
