import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/hospitals/logic/hospitals_cubit.dart';
import 'package:tips_n_steps/feature/hospitals/view/components/hospital_card.dart';

/// NOTE: `AppRoutes.hospitalDetail` referenced below is a new route constant
/// that must be added to `app_routes.dart` / `app_routes_implementation.dart`
/// (see final report for exact lines) — this feature's code cannot compile
/// until that manual merge lands, per the constraint that this pass doesn't
/// edit routing files directly.
class HospitalsView extends StatelessWidget {
  const HospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HospitalsCubit>(
      create: (_) => sl<HospitalsCubit>()..loadHospitals(),
      child: BlocBuilder<HospitalsCubit, HospitalsState>(
        builder: (context, state) {
          Widget body;
          if (state.status == HospitalsStatus.loading ||
              state.status == HospitalsStatus.initial) {
            body = const Center(child: CircularProgressIndicator());
          } else if (state.status == HospitalsStatus.error) {
            body = Center(
                child: Text(state.errorMessage ?? 'تعذر تحميل قائمة المستشفيات'));
          } else if (state.hospitals.isEmpty) {
            body = const Center(child: Text('لا توجد مستشفيات متاحة حالياً'));
          } else {
            body = ListView.builder(
              padding: EdgeInsets.all(16.W),
              itemCount: state.hospitals.length,
              itemBuilder: (context, index) {
                final hospital = state.hospitals[index];
                // Fixes the confirmed bug: HospitalCard previously had no
                // onTap at all (dead-end list, no detail screen reachable).
                return HospitalCard(
                  hospital: hospital,
                  onTap: () => context.pushNamed(
                    AppRoutes.hospitalDetail,
                    arguments: hospital.id,
                  ),
                );
              },
            );
          }

          return AppLayout(
            currentRoute: '/hospitals',
            title: 'المستشفيات',
            subtitle: 'ابحث عن أقرب مستشفى لطفلك',
            useScrollContainer: false,
            body: body,
          );
        },
      ),
    );
  }
}
