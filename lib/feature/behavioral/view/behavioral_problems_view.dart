import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/behavioral/data/model/behavioral_problem_model.dart';
import 'package:tips_n_steps/feature/behavioral/view/behavioral_detail_view.dart';
import 'package:tips_n_steps/feature/behavioral/view/components/behavioral_problem_card.dart';

class BehavioralProblemsView extends StatefulWidget {
  const BehavioralProblemsView({super.key});

  @override
  State<BehavioralProblemsView> createState() => _BehavioralProblemsViewState();
}

class _BehavioralProblemsViewState extends State<BehavioralProblemsView> {
  int? _selectedProblemId;

  final List<BehavioralProblemModel> _problems = [
    BehavioralProblemModel(
      id: 1,
      title: 'نوبات الغضب',
      illustration: '😤',
      colorStart: const Color(0xFFF37423),
      colorEnd: const Color(0xFFD97706),
      description:
          'نوبات الغضب شائعة جداً عند الأطفال الصغار، وهي تعبير عن الإحباط لعدم قدرتهم على التعبير عما يريدون بوضوح.',
      causes: [
        'عدم القدرة على التعبير عن الرغبات',
        'الجوع أو التعب الشديد',
        'الحاجة للانتباه والاهتمام',
        'اختبار الحدود والقيود المفروضة'
      ],
      solutions: [
        'ابق هادئاً: الغضب من طرفك سيزيد الوضع سوءاً',
        'تجاهل السلوك: إذا لم يكن هناك خطر، فالتجاهل قد ينهي النوبة',
        'تشتيت الانتباه: حاول لفت انتباه الطفل لشيء آخر',
        'التحدث بعد النوبة: انتظر حتى يهدأ تماماً ثم تحدث معه'
      ],
      expertTips: [
        'لاحظ مسببات الغضب وتعرف عليها',
        'ثبت روتيناً يومياً للأكل والنوم',
        'امدح الطفل عندما يعبر عن غضبه بهدوء'
      ],
    ),
    BehavioralProblemModel(
      id: 2,
      title: 'العناد',
      illustration: '😤',
      colorStart: const Color(0xFFF37423),
      colorEnd: const Color(0xFFD97706),
      description: 'العناد هو مرحلة طبيعية في تطور استقلالية الطفل وشخصيته.',
      causes: [
        'الرغبة في الاستقلال والخصوصية',
        'تقليد الكبار في البيت',
        'عدم فهم القواعد بوضوح'
      ],
      solutions: [
        'اعطِ خيارات: هل تريد التفاح أم الموز؟',
        'استخدم اللغة الإيجابية بدل "لا"',
        'اشرح الأسباب ببساطة'
      ],
      expertTips: [
        'كن مرناً في الأمور غير الجوهرية',
        'تجنب الصراع المباشر على السلطة',
        'التزم بالثبات في القواعد الأساسية'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedProblemId != null) {
      final problem = _problems.firstWhere((p) => p.id == _selectedProblemId);
      return BehavioralDetailView(
        problem: problem,
        onBack: () => setState(() => _selectedProblemId = null),
      );
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'المشكلات السلوكية',
              subtitle: 'كيفية التعامل مع سلوكيات طفلك',
              showBackButton: true),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                _buildInfoCard(),
                16.vS,
                ..._problems.map((problem) => BehavioralProblemCard(
                      problem: problem,
                      onTap: () =>
                          setState(() => _selectedProblemId = problem.id),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: const Color(0xFFF37423).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(24.R),
        border:
            Border.all(color: const Color(0xFFF37423).withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡', style: TextStyle(fontSize: 24.SP)),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'نصيحة تربوية',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFFc45a0a)),
                ),
                Text(
                  'تذكر أن السلوك هو لغة يعبر بها الطفل عن احتياجاته. فهم السبب هو الخطوة الأولى للحل.',
                  style: TextStyle(
                      fontSize: 12.SP, color: const Color(0xFFa34e0a)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
