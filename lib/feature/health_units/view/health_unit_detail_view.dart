import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

/// Simplified: no `address`/`phone`/`hours`/`vaccinations`/`facilities` exist
/// on the backend content item — this view now only renders the real
/// `title`/`body`/`tags`-derived data.
class HealthUnitDetailView extends StatelessWidget {
  final HealthUnitModel unit;
  final VoidCallback onBack;

  const HealthUnitDetailView({
    super.key,
    required this.unit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.H, bottom: 20.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [Colors.cyan, Colors.blue]),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.R)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),
                8.hS,
                Expanded(
                  child: Text(
                    unit.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.SP,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                if (unit.thumbnailUrl != null && unit.thumbnailUrl!.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.R),
                    child: Image.network(unit.thumbnailUrl!,
                        height: 160.H, width: double.infinity, fit: BoxFit.cover),
                  ),
                  20.vS,
                ],
                Text(
                  unit.description.isNotEmpty
                      ? unit.description
                      : 'لا يوجد وصف متاح لهذه الوحدة حالياً.',
                  style: TextStyle(
                      color: AppColors.gray700, fontSize: 14.SP, height: 1.5),
                ),
                if (unit.services.isNotEmpty) ...[
                  24.vS,
                  _buildSectionTitle(Icons.check_circle, 'الخدمات المتوفرة'),
                  Wrap(
                    spacing: 8.W,
                    children: unit.services
                        .map((s) => Chip(
                              label: Text(s, style: TextStyle(fontSize: 12.SP)),
                              backgroundColor: Colors.cyan.shade50,
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.H),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan, size: 20.W),
          8.hS,
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.SP),
          ),
        ],
      ),
    );
  }
}
