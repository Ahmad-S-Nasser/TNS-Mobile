import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/info_card.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_field_card.dart';
import 'package:tips_n_steps/feature/growth/view/growth_field_detail_view.dart';

class GrowthFieldsView extends StatefulWidget {
  const GrowthFieldsView({super.key});

  @override
  State<GrowthFieldsView> createState() => _GrowthFieldsViewState();
}

class _GrowthFieldsViewState extends State<GrowthFieldsView> {
  int? _selectedFieldId;

  final List<GrowthFieldModel> _fields = [
    GrowthFieldModel(
      id: 1,
      title: 'النمو الجسدي',
      description: 'متابعة الوزن والطول والتطور الحركي',
      illustration: '👦📏',
      colorStart: Colors.blue.shade400,
      colorEnd: Colors.blue.shade500,
      bgColor: Colors.blue.shade50,
      iconPath: AppIcons.activity,
      stats: {'current': '12 كجم', 'target': '13 كجم', 'progress': 85},
      milestones: [
        {'age': '12 شهر', 'achieved': true, 'title': 'يمشي بمساعدة'},
        {'age': '15 شهر', 'achieved': true, 'title': 'يمشي بمفرده'},
        {'age': '18 شهر', 'achieved': false, 'title': 'يركض ويقفز'},
      ],
      tips: [
        'شجع طفلك على اللعب النشط يومياً',
        'تأكد من تناول وجبات صحية متوازنة',
        'راقب تطور المهارات الحركية الدقيقة',
      ],
      metrics: [
        {
          'label': 'الوزن',
          'value': '12 كجم',
          'trend': '+0.5',
          'status': 'طبيعي'
        },
        {'label': 'الطول', 'value': '78 سم', 'trend': '+2', 'status': 'طبيعي'},
        {
          'label': 'محيط الرأس',
          'value': '46 سم',
          'trend': '+0.3',
          'status': 'طبيعي'
        },
      ],
    ),
    GrowthFieldModel(
      id: 2,
      title: 'النمو العقلي',
      description: 'تتبع التطور المعرفي والذهني',
      illustration: '🧠👶',
      colorStart: Colors.purple.shade400,
      colorEnd: Colors.purple.shade500,
      bgColor: Colors.purple.shade50,
      iconPath: AppIcons.brain,
      stats: {'current': 'جيد جداً', 'target': 'ممتاز', 'progress': 75},
      milestones: [
        {
          'age': '12 شهر',
          'achieved': true,
          'title': 'يتعرف على الأشياء المألوفة'
        },
        {'age': '15 شهر', 'achieved': true, 'title': 'يحل مشاكل بسيطة'},
        {'age': '18 شهر', 'achieved': false, 'title': 'يفهم التعليمات المركبة'},
      ],
      tips: [
        'العب معه ألعاب الألغاز البسيطة',
        'اقرأ له قصصاً يومياً',
        'شجع الفضول والاستكشاف الآمن',
      ],
      metrics: [
        {
          'label': 'التركيز',
          'value': '10 دقائق',
          'trend': '+2',
          'status': 'جيد'
        },
        {
          'label': 'الذاكرة',
          'value': 'قوية',
          'trend': 'ثابت',
          'status': 'ممتاز'
        },
        {
          'label': 'حل المشكلات',
          'value': 'متوسط',
          'trend': '+1',
          'status': 'جيد'
        },
      ],
    ),
    GrowthFieldModel(
      id: 3,
      title: 'اللغة والتواصل',
      description: 'مراقبة تطور المهارات اللغوية',
      illustration: '🗣️👧',
      colorStart: Colors.pink.shade400,
      colorEnd: Colors.pink.shade500,
      bgColor: Colors.pink.shade50,
      iconPath: AppIcons.messageCircle,
      stats: {'current': '50 كلمة', 'target': '75 كلمة', 'progress': 67},
      milestones: [
        {'age': '12 شهر', 'achieved': true, 'title': 'ينطق كلمات بسيطة'},
        {'age': '15 شهر', 'achieved': true, 'title': 'يستخدم 10-20 كلمة'},
        {'age': '18 شهر', 'achieved': false, 'title': 'يكون جمل من كلمتين'},
      ],
      tips: [
        'تحدث معه باستمرار واستمع له',
        'سمّ الأشياء وكرر الكلمات',
        'غنّ له أغاني الأطفال البسيطة',
      ],
      metrics: [
        {
          'label': 'عدد الكلمات',
          'value': '50 كلمة',
          'trend': '+12',
          'status': 'جيد'
        },
        {'label': 'الفهم', 'value': 'عالي', 'trend': 'ثابت', 'status': 'ممتاز'},
        {'label': 'التعبير', 'value': 'متوسط', 'trend': '+5', 'status': 'جيد'},
      ],
    ),
    GrowthFieldModel(
      id: 4,
      title: 'النمو الاجتماعي',
      description: 'تطور المهارات الاجتماعية والعاطفية',
      illustration: '👨‍👩‍👧‍👦💕',
      colorStart: Colors.green.shade400,
      colorEnd: Colors.green.shade500,
      bgColor: Colors.green.shade50,
      iconPath: AppIcons.target,
      stats: {'current': 'جيد', 'target': 'جيد جداً', 'progress': 70},
      milestones: [
        {'age': '12 شهر', 'achieved': true, 'title': 'يبتسم للآخرين'},
        {'age': '15 شهر', 'achieved': true, 'title': 'يلعب بجانب الأطفال'},
        {'age': '18 شهر', 'achieved': false, 'title': 'يشارك الألعاب'},
      ],
      tips: [
        'رتب لقاءات لعب مع أطفال آخرين',
        'علمه مشاركة الألعاب والطعام',
        'امدح السلوكيات الاجتماعية الإيجابية',
      ],
      metrics: [
        {'label': 'التفاعل', 'value': 'نشط', 'trend': '+1', 'status': 'جيد'},
        {
          'label': 'التعاطف',
          'value': 'متوسط',
          'trend': 'ثابت',
          'status': 'طبيعي'
        },
        {'label': 'المشاركة', 'value': 'يتحسن', 'trend': '+2', 'status': 'جيد'},
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedFieldId != null) {
      final field = _fields.firstWhere((f) => f.id == _selectedFieldId);
      return GrowthFieldDetailView(
        field: field,
        onBack: () => setState(() => _selectedFieldId = null),
      );
    }

    return AppLayout(
      currentRoute: '/growth-fields',
      title: 'مجالات النمو',
      subtitle: 'تابع نمو طفلك في جميع المجالات',
      showBackButton: true,
      onBack: () => context.pop(),
      useScrollContainer: false,
      body: ListView(
        padding: EdgeInsets.all(16.W),
        children: [
          const InfoCard(
            emoji: '📊',
            title: 'متابعة شاملة للنمو',
            description:
                'اضغط على أي مجال لعرض التفاصيل الكاملة والمعالم التطورية والنصائح',
          ),
          16.vS,
          ..._fields.map((field) => GrowthFieldCard(
                field: field,
                onTap: () => setState(() => _selectedFieldId = field.id),
              )),
        ],
      ),
    );
  }
}
