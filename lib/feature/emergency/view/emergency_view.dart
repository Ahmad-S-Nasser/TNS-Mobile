import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_contact_card.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_disclaimer_card.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_kit_button.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_tip_card.dart';
import 'package:tips_n_steps/feature/emergency/view/emergency_tip_detail_view.dart';
import 'package:tips_n_steps/feature/emergency/view/first_aid_kit_view.dart';

class EmergencyView extends StatefulWidget {
  final bool showBottomNav;

  const EmergencyView({super.key, this.showBottomNav = true});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  int? _selectedTipId;
  bool _showFirstAidKit = false;

  final List<EmergencyNumberModel> _emergencyNumbers = [
    EmergencyNumberModel(
        id: 1,
        title: 'الإسعاف',
        number: '123',
        illustration: '🚑',
        colorStart: Colors.red,
        colorEnd: Colors.red.shade700,
        description: 'خدمة الإسعاف',
        available: '24/7'),
    EmergencyNumberModel(
        id: 2,
        title: 'الشرطة',
        number: '122',
        illustration: '🚓',
        colorStart: Colors.blue,
        colorEnd: Colors.blue.shade700,
        description: 'شرطة النجدة',
        available: '24/7'),
    EmergencyNumberModel(
        id: 3,
        title: 'المطافئ',
        number: '180',
        illustration: '🚒',
        colorStart: Colors.orange,
        colorEnd: Colors.orange.shade700,
        description: 'الدفاع المدني',
        available: '24/7'),
    EmergencyNumberModel(
        id: 4,
        title: 'النجدة',
        number: '122',
        illustration: '🚨',
        colorStart: Colors.indigo,
        colorEnd: Colors.indigo.shade700,
        description: 'شرطة النجدة',
        available: '24/7'),
  ];

  final List<EmergencyTipModel> _emergencyTips = [
    EmergencyTipModel(
      id: 1,
      title: 'الغصة (الشرقة)',
      illustration: '🤮',
      colorStart: const Color(0xFFFACC15),
      colorEnd: const Color(0xFFEAB308),
      severity: 'حرج',
      icon: Icons.warning_amber_rounded,
      steps: [
        'انحنِ للأمام واضرب 5 ضربات قوية بين لوحي الكتف',
        'إذا لم يخرج الجسم، قم بـ 5 ضغطات على البطن (مناورة هيمليك)',
        'كرر العملية حتى يخرج الجسم أو يفقد الطفل الوعي',
        'إذا فقد الوعي، ابدأ الإنعاش القلبي الرئوي فوراً واتصل بـ 123'
      ],
      warning: 'لا تحاول إخراج الجسم الغريب بإصبعك إذا لم تكن تراه بوضوح',
      prevention: [
        'قطع الطعام لقطع صغيرة جداً',
        'ابعد الألعاب الصغيرة والعملات',
        'تأكد من جلوس الطفل أثناء الأكل'
      ],
    ),
    EmergencyTipModel(
      id: 2,
      title: 'الجروح والنزيف',
      illustration: '🤕',
      colorStart: const Color(0xFFFB7185),
      colorEnd: const Color(0xFFE11D48),
      severity: 'متوسط',
      icon: Icons.healing,
      steps: [
        'اضغط بقوة على الجرح بقطعة قماش نظيفة أو شاش',
        'ارفع العضو المصاب للأعلى إن أمكن',
        'إذا لم يتوقف النزيف، لا تنزع الشاش، بل أضف فوقه طبقة أخرى واحكم الضغط',
        'بمجرد توقف النزيف، نظف الجرح بمحلول ملحي أو ماء نظيف وغطه'
      ],
      warning: 'لا تستخدم القطن مباشرة على الجرح المفتوح لأنه يلتصق به',
      prevention: [
        'احفظ السكاكين والأدوات الحادة بعيداً',
        'غطِّ زوايا الأثاث الحادة',
        'راقب الطفل أثناء اللعب'
      ],
    ),
    EmergencyTipModel(
      id: 3,
      title: 'فقدان الوعي',
      illustration: '😴',
      colorStart: const Color(0xFF818CF8),
      colorEnd: const Color(0xFF4F46E5),
      severity: 'حرج جداً',
      icon: Icons.info_outline,
      steps: [
        'تأكد من سلامة المكان حولك وحول المصاب',
        'هز كتف المصاب بلين واسأله بصوت عال: "هل أنت بخير؟"',
        'إذا لم يرد، اطلب من شخص ما الاتصال بـ 123 فوراً',
        'افتح مجرى الهواء بإمالة الرأس للخلف ورفع الذقن',
        'تحقق من التنفس لمدة 10 ثوانٍ (انظر، اسمع، اشعر)',
        'إذا كان لا يتنفس، ابدأ الإنعاش القلبي الرئوي (CPR)'
      ],
      warning: 'لا تترك المصاب وحيداً أبداً وانتظر وصول الإسعاف',
      prevention: [
        'تعلم قواعد الإنعاش القلبي الرئوي للأطفال',
        'احصل على حقيبة إسعافات متكاملة',
        'حدث أرقام الطوارئ باستمرار'
      ],
    ),
    EmergencyTipModel(
      id: 4,
      title: 'الحروق',
      illustration: '🔥',
      colorStart: const Color(0xFFFB923C),
      colorEnd: const Color(0xFFEA580C),
      severity: 'متوسط',
      icon: Icons.fireplace,
      steps: [
        'ضع المنطقة المحروقة تحت ماء بارد جاري (ليس ثلجاً) لمدة 10-20 دقيقة',
        'اخلع الملابس بعناية إذا لم تكن ملتصقة بالجلد',
        'غطِّ الحرق بضمادة معقمة أو قماش نظيف',
        'لا تضع معجون أسنان أو زيت أو أي مواد منزلية',
        'اذهب للمستشفى فوراً، خاصة للحروق الكبيرة أو في الوجه'
      ],
      warning: 'لا تفقع الفقاعات! ولا تستخدم ثلج مباشرة على الحرق',
      prevention: [
        'ابعد الطفل عن المطبخ أثناء الطهي',
        'احفظ الأشياء الساخنة بعيداً',
        'استخدم حواجز للفرن'
      ],
    ),
    EmergencyTipModel(
      id: 5,
      title: 'التسمم',
      illustration: '🧪',
      colorStart: const Color(0xFF4ADE80),
      colorEnd: const Color(0xFF16A34A),
      severity: 'حرج جداً',
      icon: Icons.science,
      steps: [
        'اتصل بمركز السموم أو الإسعاف فوراً',
        'لا تحاول جعل الطفل يتقيأ إلا إذا طلب منك المسعف ذلك',
        'إذا كان السم على الجلد، اغسله بماء وفير لمدة 15 دقيقة',
        'إذا ابتلع سائل تنظيف، أعطه حليب أو ماء فوراً',
        'لا تعطِ أي شيء إذا كان فاقد الوعي',
        'اذهب للطوارئ حاملاً عبوة المادة'
      ],
      warning: 'لا تجعل الطفل يتقيأ إذا ابتلع مواد كاوية (منظفات قوية/بنزين)',
      prevention: [
        'احفظ الأدوية والمنظفات في خزانة مقفلة',
        'استخدم أقفال أمان للأطفال',
        'لا تنقل المنظفات لزجاجات غذاء'
      ],
    ),
    EmergencyTipModel(
      id: 6,
      title: 'الإسهال والجفاف',
      illustration: '💧',
      colorStart: const Color(0xFF60A5FA),
      colorEnd: const Color(0xFF3B82F6),
      severity: 'متوسط',
      icon: Icons.opacity,
      steps: [
        'أعطِ محلول معالجة الجفاف (ORS) بكميات صغيرة ومتكررة',
        'استمر في الرضاعة الطبيعية أو الصناعية',
        'لا توقف الطعام - قدم وجبات خفيفة',
        'راقب علامات الجفاف: جفاف الفم، قلة البول، خمول',
        'تجنب العصائر والمشروبات الغازية',
        'اذهب للطوارئ إذا: الطفل رضيع أقل من 6 أشهر، إسهال شديد مع حمى، دم في البراز'
      ],
      warning:
          'الجفاف خطر على الرضع والأطفال الصغار - لا تتأخر في طلب المساعدة',
      prevention: [
        'اغسل يدي الطفل قبل الأكل',
        'نظف الخضار والفواكه جيداً',
        'تجنب الطعام المكشوف'
      ],
    ),
    EmergencyTipModel(
      id: 7,
      title: 'التشنجات الحرارية',
      illustration: '🥵',
      colorStart: const Color(0xFFF87171),
      colorEnd: const Color(0xFFFB923C),
      severity: 'حرج',
      icon: Icons.show_chart,
      steps: [
        'ضع الطفل على جانبه في مكان آمن',
        'أبعد الأشياء الصلبة من حوله',
        'لا تضع أي شيء في فمه',
        'لا تحاول منع حركة التشنج',
        'سجل مدة التشنج',
        'بعد انتهاء التشنج، ضعه في وضع الاستشفاء',
        'اتصل بالإسعاف إذا: استمر أكثر من 5 دقائق، أول مرة، عمر أقل من 6 أشهر'
      ],
      warning:
          'التشنجات الحرارية شائعة لكن مخيفة - ابق هادئاً واحمِ الطفل من الإصابة',
      prevention: [
        'أعطِ خافض حرارة عند ارتفاع الحرارة',
        'راقب الحرارة عند المرض',
        'استشر الطبيب'
      ],
    ),
    EmergencyTipModel(
      id: 8,
      title: 'صعوبة التنفس',
      illustration: '😰',
      colorStart: const Color(0xFF22D3EE),
      colorEnd: const Color(0xFF3B82F6),
      severity: 'حرج جداً',
      icon: Icons.air,
      steps: [
        'اتصل بالإسعاف على 123 فوراً',
        'أجلس الطفل في وضع مستقيم',
        'افتح النوافذ للتهوية',
        'أبعد أي شيء يضغط على صدره',
        'ابق هادئاً وطمئن الطفل',
        'إذا كان لديه بخاخة ربو، استخدمها',
        'راقب لون الشفاه والأظافر (الزرقة = طوارئ)'
      ],
      warning: 'صعوبة التنفس حالة طارئة - لا تتردد في الاتصال بالإسعاف',
      prevention: [
        'ابعد الطفل عن الدخان',
        'تجنب مسببات الحساسية المعروفة',
        'احتفظ ببخاخة الطوارئ'
      ],
    ),
  ];

  final List<FirstAidKitItemModel> _firstAidKit = [
    FirstAidKitItemModel(item: 'ترمومتر رقمي', emoji: '🌡️'),
    FirstAidKitItemModel(item: 'ضمادات معقمة بأحجام مختلفة', emoji: '🩹'),
    FirstAidKitItemModel(item: 'شاش طبي', emoji: '📦'),
    FirstAidKitItemModel(item: 'لاصق طبي', emoji: '📏'),
    FirstAidKitItemModel(item: 'مقص طبي', emoji: '✂️'),
    FirstAidKitItemModel(item: 'ملقط', emoji: '🔧'),
    FirstAidKitItemModel(item: 'قفازات طبية', emoji: '🧤'),
    FirstAidKitItemModel(item: 'محلول معقم (كحول/بيتادين)', emoji: '🧴'),
    FirstAidKitItemModel(item: 'خافض حرارة (باراسيتامول)', emoji: '💊'),
    FirstAidKitItemModel(item: 'محلول معالجة جفاف ORS', emoji: '🥤'),
    FirstAidKitItemModel(item: 'مرهم حروق', emoji: '🧴'),
    FirstAidKitItemModel(item: 'قطن طبي', emoji: '☁️'),
  ];

  @override
  Widget build(BuildContext context) {
    if (_showFirstAidKit) {
      return FirstAidKitView(
        kitItems: _firstAidKit,
        onBack: () => setState(() => _showFirstAidKit = false),
      );
    }
    if (_selectedTipId != null) {
      final tip = _emergencyTips.firstWhere((t) => t.id == _selectedTipId);
      return EmergencyTipDetailView(
        tip: tip,
        onBack: () => setState(() => _selectedTipId = null),
      );
    }

    return AppLayout(
      showBottomNav: widget.showBottomNav,
      currentRoute: '/emergency',
      title: 'الطوارئ',
      subtitle: 'أرقام الطوارئ والإسعافات الأولية',
      useScrollContainer: false,
      body: ListView(
        padding: EdgeInsets.all(16.W),
        children: [
          _buildSectionHeader('أرقام الطوارئ'),
          12.vS,
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.H,
            crossAxisSpacing: 12.W,
            childAspectRatio: 0.85,
            children: _emergencyNumbers
                .map((number) => EmergencyContactCard(contact: number))
                .toList(),
          ),
          24.vS,
          EmergencyKitButton(
            onTap: () => setState(() => _showFirstAidKit = true),
          ),
          24.vS,
          _buildSectionHeader('دليل الإسعافات الأولية'),
          12.vS,
          ..._emergencyTips.map((tip) => EmergencyTipCard(
                tip: tip,
                onTap: () => setState(() => _selectedTipId = tip.id),
              )),
          24.vS,
          const EmergencyDisclaimerCard(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 22.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800));
  }
}
