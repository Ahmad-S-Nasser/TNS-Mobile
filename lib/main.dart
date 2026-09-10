import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/di/service_locator.dart' as di;
import 'package:tips_n_steps/core/helpers/extension.dart' show nK;
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/routing/app_routes_implementation.dart';
import 'package:tips_n_steps/core/theme/app_theme.dart';
import 'package:tips_n_steps/feature/notifications/logic/notifications_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TipsNStepsApp());
}

class TipsNStepsApp extends StatelessWidget {
  const TipsNStepsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..checkSession(),
        ),
        BlocProvider<NotificationsCubit>(
          create: (_) => di.sl<NotificationsCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            // Only react to a session dying while the user was actually
            // inside the app (a 401-triggered forceLogout) — not to the
            // initial unknown -> unauthenticated resolution at splash,
            // which the splash screen itself already navigates for.
            listenWhen: (previous, current) =>
                previous.isAuthenticated && !current.isAuthenticated,
            listener: (context, state) {
              nK.currentState?.pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            // Fetch the notification list (for the header badge) the
            // moment a session becomes authenticated — covers both a fresh
            // login and an already-valid session found at splash.
            // Deliberately NOT fetched eagerly at BlocProvider creation:
            // at cold boot with no stored token that would hit
            // GET /mobile/notifications unauthenticated and trigger a
            // spurious forceLogout/"session expired" message before the
            // user ever logged in.
            listenWhen: (previous, current) =>
                !previous.isAuthenticated && current.isAuthenticated,
            listener: (context, state) {
              di.sl<NotificationsCubit>().loadNotifications();
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Tips n Steps',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              navigatorKey: nK,
              onGenerateRoute: AppRoutesImplementation.onGenerateRoute,
              initialRoute: AppRoutes.splash,
              locale: const Locale('ar', 'EG'),
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
