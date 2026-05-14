import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/feature/onboarding/view/components/onboarding_background.dart';
import 'package:tips_n_steps/feature/onboarding/view/components/onboarding_bottom_card.dart';
import 'package:tips_n_steps/feature/onboarding/view/components/onboarding_slide_illustration.dart';
import 'package:tips_n_steps/feature/onboarding/view/components/onboarding_top_bar.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _floatController;
  late AnimationController _pulseController;
  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      image: AppImages.onboardingWelcome,
      tag: '💛  مرحباً بكِ',
      headline: 'رحلتكِ مع\nطفلكِ تبدأ هنا',
      body:
          'Tips n Steps رفيقتكِ اليومية لتربية طفلكِ بثقة، ومتابعة نموّه خطوةً بخطوة.',
      accent: const Color(0xFFF37423),
    ),
    OnboardingSlide(
      image: AppImages.onboardingLearning,
      tag: '📚  تعلّمي',
      headline: 'نصائح موثوقة\nفي كل خطوة',
      body:
          'محتوى تعليمي متخصص ونصائح عملية تساعدكِ على فهم احتياجات طفلكِ في كل مرحلة.',
      accent: const Color(0xFF23A99A),
    ),
    OnboardingSlide(
      image: AppImages.behavioral,
      tag: '🌸  مجتمعكِ',
      headline: 'لستِ وحدكِ\nفي هذه الرحلة',
      body:
          'انضمي لمجتمع من الأمهات، اسألي واستفيدي من تجارب حقيقية في بيئة آمنة ودافئة.',
      accent: const Color(0xFFF37423),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Layer
          OnboardingBackground(pulseController: _pulseController),

          // Content Layer
          Column(
            children: [
              // Top Bar
              const OnboardingTopBar(),

              // Slides Area
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    return OnboardingSlideIllustration(
                      index: index,
                      slide: _slides[index],
                      floatController: _floatController,
                    );
                  },
                ),
              ),

              // Bottom White Card
              OnboardingBottomCard(
                currentIndex: _currentIndex,
                slides: _slides,
                onNext: _onNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingSlide {
  final String image;
  final String tag;
  final String headline;
  final String body;
  final Color accent;

  OnboardingSlide({
    required this.image,
    required this.tag,
    required this.headline,
    required this.body,
    required this.accent,
  });
}
