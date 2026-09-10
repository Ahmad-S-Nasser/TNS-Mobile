import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/splash/view/components/splash_background.dart';
import 'package:tips_n_steps/feature/splash/view/components/splash_footer.dart';
import 'package:tips_n_steps/feature/splash/view/components/splash_logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _loopController;

  // Entry Animations
  late Animation<double> _logoScale;
  late Animation<double> _contentFadeUp;
  late Animation<double> _barWidth;
  late Animation<double> _footerFadeUp;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _loopController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Logo elastic scale-in
    _logoScale = Tween<double>(begin: 0.78, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.08, 0.4, curve: Curves.elasticOut),
      ),
    );

    // Fade up for name and tagline
    _contentFadeUp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.28, 0.55, curve: Curves.easeOut),
      ),
    );

    // Accent bar growth
    _barWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.46, 0.75, curve: Curves.easeOut),
      ),
    );

    // Footer fade up
    _footerFadeUp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.55, 0.85, curve: Curves.easeOut),
      ),
    );

    _entryController.forward();

    Future.delayed(const Duration(milliseconds: 4000), _navigateNext);
  }

  Future<void> _navigateNext() async {
    if (!mounted) return;
    final authCubit = context.read<AuthCubit>();
    var authState = authCubit.state;
    if (authState.status == AuthStatus.unknown) {
      // checkSession() is a fast local-storage read triggered at app start;
      // in the rare case it hasn't resolved by the time the splash
      // animation finishes, wait for it (capped, so a slow device never
      // hangs on the splash screen).
      authState = await authCubit.stream
          .firstWhere((s) => s.status != AuthStatus.unknown)
          .timeout(const Duration(seconds: 3), onTimeout: () => authState);
    }
    if (!mounted) return;
    context.pushReplacementNamed(
      authState.isAuthenticated ? AppRoutes.home : AppRoutes.onboarding,
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.splashGradient),
        child: Stack(
          children: [
            // Background Layer
            SplashBackground(loopController: _loopController),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Centre Logo Content
                  SplashLogo(
                    entryController: _entryController,
                    loopController: _loopController,
                    logoScale: _logoScale,
                    contentFadeUp: _contentFadeUp,
                    barWidth: _barWidth,
                  ),

                  const Spacer(flex: 3),

                  // Bottom Content
                  SplashFooter(
                    entryController: _entryController,
                    footerFadeUp: _footerFadeUp,
                  ),

                  40.vS,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
