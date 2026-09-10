import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/hospitals/logic/hospitals_cubit.dart';

/// New screen (the confirmed bug was that hospitals had no tap handler / no
/// detail route at all). Shows name/body/thumbnailUrl; the call button only
/// appears when a phone-like value was actually found in the content item's
/// `tags` (see `HospitalModel._extractPhone`) — never invented.
class HospitalDetailView extends StatelessWidget {
  final String hospitalId;

  const HospitalDetailView({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HospitalsCubit>(
      create: (_) => sl<HospitalsCubit>()..loadHospitalById(hospitalId),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const AppHeader(title: 'تفاصيل المستشفى', showBackButton: true),
            Expanded(
              child: BlocBuilder<HospitalsCubit, HospitalsState>(
                builder: (context, state) {
                  if (state.status == HospitalsStatus.loading ||
                      state.status == HospitalsStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final hospital = state.selectedHospital;
                  if (state.status == HospitalsStatus.error || hospital == null) {
                    return Center(
                        child: Text(
                            state.errorMessage ?? 'تعذر تحميل بيانات المستشفى'));
                  }
                  return ListView(
                    padding: EdgeInsets.all(20.W),
                    children: [
                      if (hospital.thumbnailUrl != null &&
                          hospital.thumbnailUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.R),
                          child: Image.network(
                            hospital.thumbnailUrl!,
                            height: 180.H,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          height: 120.H,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(20.R),
                          ),
                          child: Center(
                              child: Text(hospital.illustration,
                                  style: TextStyle(fontSize: 48.SP))),
                        ),
                      16.vS,
                      Text(hospital.name,
                          style: TextStyle(
                              fontSize: 20.SP, fontWeight: FontWeight.bold)),
                      if (hospital.rating != null) ...[
                        8.vS,
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            4.hS,
                            Text(hospital.rating!.toStringAsFixed(1),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13.SP)),
                          ],
                        ),
                      ],
                      16.vS,
                      Text(
                        hospital.description.isNotEmpty
                            ? hospital.description
                            : 'لا يوجد وصف متاح لهذا المستشفى حالياً.',
                        style: TextStyle(
                            color: AppColors.gray700, fontSize: 14.SP, height: 1.6),
                      ),
                      if (hospital.phone != null) ...[
                        24.vS,
                        SizedBox(
                          width: double.infinity,
                          height: 48.H,
                          child: ElevatedButton.icon(
                            onPressed: () => _call(hospital.phone!),
                            icon: const Icon(Icons.phone),
                            label: const Text('اتصال'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _call(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
