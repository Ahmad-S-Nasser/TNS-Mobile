import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/widgets/main_layout_wrapper.dart';
import 'package:tips_n_steps/feature/admin/view/admin_questions_view.dart';
import 'package:tips_n_steps/feature/auth/view/forgot_password_view.dart';
import 'package:tips_n_steps/feature/auth/view/login_view.dart';
import 'package:tips_n_steps/feature/auth/view/register_view.dart';
import 'package:tips_n_steps/feature/behavioral/view/behavioral_problems_view.dart';
import 'package:tips_n_steps/feature/booking/view/booking_view.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';
import 'package:tips_n_steps/feature/children/view/add_child_view.dart';
import 'package:tips_n_steps/feature/children/view/children_list_view.dart';
import 'package:tips_n_steps/feature/community/view/ask_question_view.dart';
import 'package:tips_n_steps/feature/community/view/community_view.dart';
import 'package:tips_n_steps/feature/community/view/question_detail_view.dart';
import 'package:tips_n_steps/feature/content/view/content_view.dart';
import 'package:tips_n_steps/feature/emergency/view/emergency_view.dart';
import 'package:tips_n_steps/feature/games/view/game_detail_view.dart';
import 'package:tips_n_steps/feature/games/view/pdf_preview_view.dart';
import 'package:tips_n_steps/feature/games/view/teaching_games_view.dart';
import 'package:tips_n_steps/feature/growth/view/growth_fields_view.dart';
import 'package:tips_n_steps/feature/growth/view/measurement_history_view.dart';
import 'package:tips_n_steps/feature/growth/view/measurement_view.dart';
import 'package:tips_n_steps/feature/health_units/view/health_units_view.dart';
import 'package:tips_n_steps/feature/hospitals/view/hospital_detail_view.dart';
import 'package:tips_n_steps/feature/hospitals/view/hospitals_view.dart';
import 'package:tips_n_steps/feature/main/view/main_view.dart';
import 'package:tips_n_steps/feature/notifications/view/notifications_view.dart';
import 'package:tips_n_steps/feature/onboarding/view/onboarding_view.dart';
import 'package:tips_n_steps/feature/profile/view/profile_view.dart';
import 'package:tips_n_steps/feature/settings/view/settings_view.dart';
import 'package:tips_n_steps/feature/splash/view/splash_view.dart';

import 'app_routes.dart';

class AppRoutesImplementation {
  // Routes reachable without a session. Anything else is guarded below.
  static const Set<String> _publicRoutes = {
    AppRoutes.splash,
    AppRoutes.onboarding,
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (!_publicRoutes.contains(settings.name) &&
        !sl<AuthCubit>().state.isAuthenticated) {
      return MaterialPageRoute(
        builder: (_) => const MainLayoutWrapper(
          showOverlays: false,
          child: LoginView(),
        ),
      );
    }

    Widget page;
    bool wrapWithLayout = true;

    switch (settings.name) {
      case AppRoutes.splash:
        page = const SplashView();
        wrapWithLayout = false;
        break;
      case AppRoutes.onboarding:
        page = const OnboardingView();
        wrapWithLayout = false;
        break;
      case AppRoutes.login:
        page = const LoginView();
        wrapWithLayout = false;
        break;
      case AppRoutes.register:
        page = const RegisterView();
        wrapWithLayout = false;
        break;
      case AppRoutes.forgotPassword:
        page = const ForgotPasswordView();
        wrapWithLayout = false;
        break;
      case AppRoutes.layout:
      case AppRoutes.home:
        page = const MainView();
        wrapWithLayout = false; // MainView already has MainLayoutWrapper
        break;
      case AppRoutes.profile:
        page = const ProfileView();
        break;
      case AppRoutes.settingsScreen:
        page = const SettingsView();
        break;
      case AppRoutes.children:
        page = const ChildrenListView();
        break;
      case AppRoutes.addChild:
        page = AddChildView(existingChild: settings.arguments as ChildModel?);
        break;
      case AppRoutes.growthFields:
        page = const GrowthFieldsView();
        break;
      case AppRoutes.measurement:
        page = const MeasurementView();
        break;
      case AppRoutes.measurementHistory:
        page = MeasurementHistoryView(childId: settings.arguments as String?);
        break;
      case AppRoutes.booking:
        page = const BookingView();
        break;
      case AppRoutes.behavioralProblems:
        page = const BehavioralProblemsView();
        break;
      case AppRoutes.hospitals:
        page = const HospitalsView();
        break;
      case AppRoutes.hospitalDetail:
        page = HospitalDetailView(hospitalId: settings.arguments as String? ?? '');
        break;
      case AppRoutes.healthUnits:
        page = const HealthUnitsView();
        break;
      case AppRoutes.teachingGames:
        page = const TeachingGamesView();
        break;
      case AppRoutes.content:
        page = const ContentView();
        break;
      case AppRoutes.emergency:
        page = const EmergencyView();
        break;
      case AppRoutes.community:
        page = const CommunityView();
        wrapWithLayout =
            false; // Usually hidden in community screens as per React logic
        break;
      case AppRoutes.askQuestion:
        page = const AskQuestionView();
        wrapWithLayout = false;
        break;
      case AppRoutes.adminQuestions:
        page = const AdminQuestionsView();
        wrapWithLayout = false;
        break;
      case AppRoutes.questionDetail:
        page = QuestionDetailView(questionId: settings.arguments as String);
        wrapWithLayout = false;
        break;
      case AppRoutes.gameDetail:
        page = GameDetailView(gameId: settings.arguments as String? ?? '');
        break;
      case AppRoutes.pdfPreview:
        page = PDFPreviewView(gameId: settings.arguments as String? ?? '');
        break;
      case AppRoutes.notifications:
        page = const NotificationsView();
        break;
      default:
        if (settings.name?.startsWith('/community/question/') ?? false) {
          page = QuestionDetailView(questionId: settings.arguments as String);
          wrapWithLayout = false;
        } else if (settings.name?.startsWith('/teaching-games/') ?? false) {
          final segments =
              settings.name!.split('/').where((s) => s.isNotEmpty).toList();
          // segments: ['teaching-games', '<id>'] or ['teaching-games', '<id>', 'pdf']
          final gameId = segments.length >= 2 ? segments[1] : '';
          if (settings.name!.endsWith('/pdf')) {
            page = PDFPreviewView(gameId: gameId);
          } else {
            page = GameDetailView(gameId: gameId);
          }
        } else {
          page = Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Center(child: Text('Route ${settings.name} not found')),
          );
        }
    }

    return MaterialPageRoute(
      builder: (_) => MainLayoutWrapper(
        showOverlays: wrapWithLayout,
        child: page,
      ),
    );
  }
}
