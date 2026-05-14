import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/service_card.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'مجالات النمو',
        'image': AppImages.growth,
        'gradient': const LinearGradient(
            colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)]),
        'accent': const Color(0xFF1B59B2),
        'path': '/growth-fields'
      },
      {
        'title': 'المشكلات السلوكية',
        'image': AppImages.behavioral,
        'gradient': const LinearGradient(
            colors: [Color(0xFFFDF2F8), Color(0xFFFCE7F3)]),
        'accent': const Color(0xFFF37423),
        'path': '/behavioral-problems'
      },
      {
        'title': 'المشكلات النفسية',
        'image': AppImages.psychological,
        'gradient': const LinearGradient(
            colors: [Color(0xFFFEFCE8), Color(0xFFFEF9C3)]),
        'accent': const Color(0xFFF37423),
        'path': '/behavioral-problems'
      },
      {
        'title': 'التغذية السليمة',
        'image': AppImages.nutrition,
        'gradient': const LinearGradient(
            colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7)]),
        'accent': const Color(0xFF23A99A),
        'path': '/content'
      },
      {
        'title': 'التثقيف الجنسي',
        'image': AppImages.sexEducation,
        'gradient': const LinearGradient(
            colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)]),
        'accent': const Color(0xFFF37423),
        'path': '/content'
      },
      {
        'title': 'ألعاب تعليمية',
        'emoji': '🎮',
        'gradient': const LinearGradient(
            colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)]),
        'accent': const Color(0xFF1B59B2),
        'path': '/teaching-games'
      },
      {
        'title': 'مجتمع الأمهات',
        'iconPath': AppIcons.community,
        'gradient': const LinearGradient(
            colors: [Color(0xFFF7FEE7), Color(0xFFECFCCB)]),
        'accent': const Color(0xFF82CD47),
        'path': '/community'
      },
      {
        'title': 'المستشفيات',
        'image': AppImages.hospitals,
        'gradient': const LinearGradient(
            colors: [Color(0xFFF0FDFA), Color(0xFFCCFBF1)]),
        'accent': const Color(0xFF23A99A),
        'path': '/hospitals'
      },
      {
        'title': 'الوحدات الصحية',
        'image': AppImages.healthUnits,
        'gradient': const LinearGradient(
            colors: [Color(0xFFECFEFF), Color(0xFFCFFAFE)]),
        'accent': const Color(0xFF23A99A),
        'path': '/health-units'
      },
      {
        'title': 'الطوارئ',
        'image': AppImages.emergency,
        'gradient': const LinearGradient(
            colors: [Color(0xFFFEF2F2), Color(0xFFFEE2E2)]),
        'accent': const Color(0xFFEF4444),
        'path': '/emergency'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.W),
          child: Text(
            'الخدمات',
            style: TextStyle(
                fontSize: 20.SP,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800),
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
        ),
        16.vS,
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.W),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.W,
            mainAxisSpacing: 16.H,
            childAspectRatio: 0.85,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return ServiceCard(
              title: item['title'],
              image: item['image'],
              iconPath: item['iconPath'],
              emoji: item['emoji'],
              gradient: item['gradient'],
              accentColor: item['accent'],
              onTap: () => context.pushNamed(item['path']),
            )
                .animate(delay: (200 + (index * 50)).ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);
          },
        ),
      ],
    );
  }
}
