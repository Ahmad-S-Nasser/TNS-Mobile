import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';
import 'package:tips_n_steps/feature/health_units/logic/health_units_cubit.dart';

/// Simplified: rendered as a flat, age-sorted list of real `section=Vaccines`
/// content items (title + body) instead of a hand-authored nested
/// age->vaccines table the backend has no endpoint for.
class VaccinationScheduleView extends StatelessWidget {
  final HealthUnitsStatus status;
  final List<VaccinationItem> schedule;
  final String? errorMessage;
  final VoidCallback onBack;

  const VaccinationScheduleView({
    super.key,
    required this.status,
    required this.schedule,
    required this.onBack,
    this.errorMessage,
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
                  const LinearGradient(colors: [Colors.purple, Colors.pink]),
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
                Text(
                  'جدول التطعيمات',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.SP,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (status == HealthUnitsStatus.loading || status == HealthUnitsStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (status == HealthUnitsStatus.error) {
      return Center(child: Text(errorMessage ?? 'تعذر تحميل جدول التطعيمات'));
    }
    if (schedule.isEmpty) {
      return const Center(child: Text('لا يتوفر جدول تطعيمات حالياً'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(20.W),
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final item = schedule[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.H),
          padding: EdgeInsets.all(16.W),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.R),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.vaccines, color: Colors.white, size: 16.W),
                  ),
                  12.hS,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.ageLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.SP,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          item.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.SP),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (item.body.isNotEmpty) ...[
                8.vS,
                Text(item.body,
                    style: TextStyle(fontSize: 12.SP, color: AppColors.gray600)),
              ],
            ],
          ),
        );
      },
    );
  }
}
