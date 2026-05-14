import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/hospitals/data/model/hospital_model.dart';
import 'package:tips_n_steps/feature/hospitals/view/components/hospital_card.dart';

class HospitalsView extends StatelessWidget {
  const HospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HospitalModel> hospitals = [
      HospitalModel(
          name: 'مستشفى الجلاء للأطفال',
          location: 'السيدة زينب - القاهرة',
          distance: '4.2 كم',
          rating: '4.7',
          illustration: '🏥'),
      HospitalModel(
          name: 'مستشفى أبو الريش الياباني',
          location: 'السيدة زينب - القاهرة',
          distance: '4.5 كم',
          rating: '4.9',
          illustration: '🏥'),
      HospitalModel(
          name: 'مستشفى النيل للأطفال',
          location: 'شبرا الخيمة - القليوبية',
          distance: '8.1 كم',
          rating: '4.5',
          illustration: '🏥'),
      HospitalModel(
          name: 'مستشفى تبارك للأطفال',
          location: 'مدينة نصر - القاهرة',
          distance: '12.3 كم',
          rating: '4.6',
          illustration: '🏥'),
    ];

    return AppLayout(
      currentRoute: '/hospitals',
      title: 'المستشفيات',
      subtitle: 'ابحث عن أقرب مستشفى لطفلك',
      useScrollContainer: false,
      body: ListView.builder(
        padding: EdgeInsets.all(16.W),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return HospitalCard(hospital: hospital);
        },
      ),
    );
  }
}
