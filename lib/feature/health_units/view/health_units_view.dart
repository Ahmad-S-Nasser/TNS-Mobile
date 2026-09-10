import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/info_card.dart';
import 'package:tips_n_steps/feature/health_units/logic/health_units_cubit.dart';
import 'package:tips_n_steps/feature/health_units/view/components/health_unit_card.dart';
import 'package:tips_n_steps/feature/health_units/view/components/vaccination_schedule_button.dart';
import 'package:tips_n_steps/feature/health_units/view/health_unit_detail_view.dart';
import 'package:tips_n_steps/feature/health_units/view/vaccination_schedule_view.dart';

class HealthUnitsView extends StatefulWidget {
  const HealthUnitsView({super.key});

  @override
  State<HealthUnitsView> createState() => _HealthUnitsViewState();
}

class _HealthUnitsViewState extends State<HealthUnitsView> {
  String? _selectedUnitId;
  bool _showVaccinationSchedule = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HealthUnitsCubit>(
      create: (_) => sl<HealthUnitsCubit>()
        ..loadUnits()
        ..loadSchedule(),
      child: BlocBuilder<HealthUnitsCubit, HealthUnitsState>(
        builder: (context, state) {
          if (_showVaccinationSchedule) {
            return VaccinationScheduleView(
              status: state.scheduleStatus,
              schedule: state.schedule,
              errorMessage: state.scheduleError,
              onBack: () => setState(() => _showVaccinationSchedule = false),
            );
          }
          if (_selectedUnitId != null) {
            final unit = state.units.firstWhere(
              (u) => u.id == _selectedUnitId,
              orElse: () => state.units.first,
            );
            return HealthUnitDetailView(
              unit: unit,
              onBack: () => setState(() => _selectedUnitId = null),
            );
          }

          Widget listContent;
          if (state.unitsStatus == HealthUnitsStatus.loading ||
              state.unitsStatus == HealthUnitsStatus.initial) {
            listContent = const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state.unitsStatus == HealthUnitsStatus.error) {
            listContent = Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                  child: Text(state.unitsError ?? 'تعذر تحميل الوحدات الصحية')),
            );
          } else if (state.units.isEmpty) {
            listContent = const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('لا توجد وحدات صحية متاحة حالياً')),
            );
          } else {
            listContent = Column(
              children: state.units
                  .map((unit) => HealthUnitCard(
                        unit: unit,
                        onTap: () => setState(() => _selectedUnitId = unit.id),
                      ))
                  .toList(),
            );
          }

          return AppLayout(
            currentRoute: '/health-units',
            title: 'الوحدات الصحية',
            subtitle: 'مراكز الرعاية الصحية الأولية',
            showBackButton: true,
            useScrollContainer: false,
            body: ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                const InfoCard(
                  emoji: '✨',
                  title: 'خدمات مجانية',
                  description:
                      'تقدم الوحدات الصحية خدمات التطعيمات والكشف الدوري ومتابعة النمو مجاناً لجميع الأطفال',
                  variant: InfoCardVariant.success,
                ),
                16.vS,
                VaccinationScheduleButton(
                  onTap: () => setState(() => _showVaccinationSchedule = true),
                ),
                16.vS,
                listContent,
              ],
            ),
          );
        },
      ),
    );
  }
}
