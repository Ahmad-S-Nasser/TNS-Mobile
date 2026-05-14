import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

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
                Text(
                  unit.description,
                  style: TextStyle(
                      color: AppColors.gray700, fontSize: 14.SP, height: 1.5),
                ),
                24.vS,
                _buildSectionTitle(Icons.map, 'معلومات التواصل'),
                _buildInfoItem('العنوان', unit.address),
                _buildInfoItem('الهاتف', unit.phone),
                _buildInfoItem('مواعيد العمل', '${unit.hours} (${unit.days})'),
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
                24.vS,
                _buildSectionTitle(Icons.medical_services, 'التطعميات المتاحة'),
                ...unit.vaccinations.map((v) => ListTile(
                      leading:
                          Icon(Icons.check, color: Colors.green, size: 24.W),
                      title: Text(v, style: TextStyle(fontSize: 14.SP)),
                    )),
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

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.H),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
