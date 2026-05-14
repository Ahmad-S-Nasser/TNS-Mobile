import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

class HealthUnitCard extends StatelessWidget {
  final HealthUnitModel unit;
  final VoidCallback onTap;
  final VoidCallback onDetailTap;
  final VoidCallback onCallTap;

  const HealthUnitCard({
    super.key,
    required this.unit,
    required this.onTap,
    required this.onDetailTap,
    required this.onCallTap,
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
                      Text(
                        unit.area,
                        style: TextStyle(
                            color: AppColors.gray500, fontSize: 12.SP),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            16.vS,
            _buildIconInfo(Icons.access_time, unit.hours),
            _buildIconInfo(Icons.calendar_today, unit.days),
            16.vS,
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: onCallTap,
                    icon: Icon(Icons.phone, size: 16.W),
                    label: const Text('اتصل'),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.R),
                      ),
                    ),
                  ),
                ),
                12.hS,
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDetailTap,
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
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.H),
      child: Row(
        children: [
          Icon(icon, size: 14.W, color: AppColors.primaryBlue),
          8.hS,
          Text(
            text,
            style: TextStyle(color: AppColors.gray600, fontSize: 12.SP),
          ),
        ],
      ),
    );
  }
}
