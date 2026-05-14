import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tips_n_steps/core/di/service_locator.dart' as di;
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/routing/app_routes_implementation.dart';
import 'package:tips_n_steps/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TipsNStepsApp());
}

class TipsNStepsApp extends StatelessWidget {
  const TipsNStepsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Tips n Steps',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
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
    );
  }
}
