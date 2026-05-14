import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/info_card.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';
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
  int? _selectedUnitId;
  bool _showVaccinationSchedule = false;

  final List<HealthUnitModel> _units = [
    HealthUnitModel(
      id: 1,
      name: 'الوحدة الصحية - المعادي',
      area: 'المعادي، القاهرة',
      address: 'شارع 153، المعادي، القاهرة',
      services: ['تطعيمات', 'رعاية أمومة وطفولة', 'كشف عام', 'متابعة نمو'],
      phone: '0225111222',
      hours: '8 صباحاً - 4 مساءً',
      days: 'السبت - الخميس',
      distance: '1.2 كم',
      illustration: '🩺',
      free: true,
      staff: 8,
      rating: 4.5,
      description:
          'وحدة صحية حكومية تقدم خدمات رعاية الأمومة والطفولة مع التطعيمات المجانية',
      vaccinations: [
        'شلل الأطفال',
        'الحصبة',
        'الثلاثي البكتيري',
        'الالتهاب الكبدي ب'
      ],
      facilities: [
        'منطقة انتظار مكيفة',
        'ثلاجة لحفظ التطعيمات',
        'غرفة فحص مجهزة'
      ],
    ),
    HealthUnitModel(
      id: 2,
      name: 'مركز رعاية الأطفال - دجلة',
      area: 'دجلة، المعادي',
      address: 'كورنيش دجلة، المعادي',
      services: ['تطعيمات', 'متابعة نمو', 'استشارات تغذية', 'فحص دوري'],
      phone: '0225333444',
      hours: '9 صباحاً - 3 مساءً',
      days: 'الأحد - الخميس',
      distance: '3.4 كم',
      illustration: '🩺',
      free: true,
      staff: 6,
      rating: 4.3,
      description: 'مركز متخصص في متابعة نمو الأطفال وتقديم استشارات التغذية',
      vaccinations: [
        'جميع التطعيمات الإجبارية',
        'التطعيمات الاختيارية المدعومة'
      ],
      facilities: ['عيادة تغذية', 'غرفة قياس الوزن والطول', 'صيدلية صغيرة'],
    ),
  ];

  final List<VaccinationItem> _vaccinationSchedule = [
    VaccinationItem(
        age: 'عند الولادة',
        vaccines: ['الدرن', 'شلل الأطفال صفر', 'الالتهاب الكبدي ب']),
    VaccinationItem(
        age: 'شهرين',
        vaccines: ['شلل الأطفال 1', 'الخماسي 1', 'المكورات الرئوية 1']),
    VaccinationItem(
        age: '4 أشهر',
        vaccines: ['شلل الأطفال 2', 'الخماسي 2', 'المكورات الرئوية 2']),
    VaccinationItem(
        age: '6 أشهر',
        vaccines: ['شلل الأطفال 3', 'الخماسي 3', 'المكورات الرئوية 3']),
    VaccinationItem(age: '9 أشهر', vaccines: ['الحصبة']),
    VaccinationItem(age: '12 شهر', vaccines: ['الثلاثي الفيروسي MMR']),
    VaccinationItem(age: '18 شهر', vaccines: ['جرعات منشطة']),
  ];

  @override
  Widget build(BuildContext context) {
    if (_showVaccinationSchedule) {
      return VaccinationScheduleView(
        schedule: _vaccinationSchedule,
        onBack: () => setState(() => _showVaccinationSchedule = false),
      );
    }
    if (_selectedUnitId != null) {
      final unit = _units.firstWhere((u) => u.id == _selectedUnitId);
      return HealthUnitDetailView(
        unit: unit,
        onBack: () => setState(() => _selectedUnitId = null),
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
          ..._units.map((unit) => HealthUnitCard(
                unit: unit,
                onTap: () => setState(() => _selectedUnitId = unit.id),
                onDetailTap: () => setState(() => _selectedUnitId = unit.id),
                onCallTap: () {
                  // Call logic here
                },
              )),
        ],
      ),
    );
  }
}
