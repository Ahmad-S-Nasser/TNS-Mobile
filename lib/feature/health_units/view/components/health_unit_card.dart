import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

/// Simplified: `area`/`hours`/`days`/`phone` had no backend equivalent (see
/// health_unit_model.dart), so the call button and those info rows were
/// dropped — the card now only shows what the content item can actually
/// provide (name + description preview) plus a details affordance.
class HealthUnitCard extends StatelessWidget {
  final HealthUnitModel unit;
  final VoidCallback onTap;

  const HealthUnitCard({
    super.key,
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60.W,
                  height: 60.H,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    borderRadius: BorderRadius.circular(20.R),
                  ),
                  child: Center(
                    child: Text(
                      unit.illustration,
                      style: TextStyle(fontSize: 24.SP),
                    ),
                  ),
                ),
                16.hS,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.SP),
                      ),
                      if (unit.description.isNotEmpty) ...[
                        4.vS,
                        Text(
                          unit.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.gray500, fontSize: 12.SP),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (unit.services.isNotEmpty) ...[
              12.vS,
              Wrap(
                spacing: 6.W,
                runSpacing: 6.H,
                children: unit.services
                    .take(4)
                    .map((s) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.W, vertical: 4.H),
                          decoration: BoxDecoration(
                            color: Colors.cyan.shade50,
                            borderRadius: BorderRadius.circular(8.R),
                          ),
                          child: Text(s, style: TextStyle(fontSize: 10.SP)),
                        ))
                    .toList(),
              ),
            ],
            12.vS,
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.R),
                  ),
                ),
                child: const Text('التفاصيل'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
