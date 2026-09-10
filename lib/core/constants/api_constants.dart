import 'dart:io' show Platform;

/// Gateway base URL.
///
/// Local dev notes:
/// - Android emulator cannot reach the host machine via `localhost` — use
///   `10.0.2.2`, which the emulator maps back to the host loopback address.
/// - iOS simulator, web, and physical devices on the same network should use
///   the host's actual `localhost`/LAN address instead.
/// - Override at build time with `--dart-define=GATEWAY_BASE_URL=http://<host>:<port>`
///   to point at staging/production without touching this file.
class ApiConstants {
  ApiConstants._();

  static const String _override =
      String.fromEnvironment('GATEWAY_BASE_URL', defaultValue: '');

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    // Gateway default port per infra docs (docker-compose publishes it on
    // 6000 in local dev). Adjust here if the gateway is exposed elsewhere.
    const port = 6000;
    if (!Platform.isAndroid) return 'http://localhost:$port';
    // Android emulator loopback-to-host alias.
    return 'http://10.0.2.2:$port';
  }

  // ---- Auth (mounted at /auth/*, NOT /mobile/auth/*) ----
  static const String authLogin = '/auth/login';
  static const String authChangePassword = '/auth/change-password';

  // ---- Users (UserManagement, /mobile/users/*) ----
  static const String usersRegister = '/mobile/users/register';
  static const String usersMe = '/mobile/users/me';
  static String userById(String id) => '/mobile/users/$id';

  // ---- Children (UserManagement, /mobile/children/*) ----
  static const String children = '/mobile/children';
  static String childById(String id) => '/mobile/children/$id';

  // ---- Content (/mobile/content/*) ----
  static const String contentSections = '/mobile/content/sections';
  static const String content = '/mobile/content';
  static String contentById(String id) => '/mobile/content/$id';
  static String contentBySection(String section) =>
      '/mobile/content/section/$section';

  // ---- Growth (/mobile/growth/*) ----
  static const String growthAgeGroups = '/mobile/growth/age-groups';
  static const String growthCategories = '/mobile/growth/categories';
  static const String growthSkills = '/mobile/growth/skills';
  static const String growthRules = '/mobile/growth/rules';
  static const String growthFields = '/mobile/growth/fields';
  static String growthFieldById(String id) => '/mobile/growth/fields/$id';
  static const String growthAssessments = '/mobile/growth/assessments';
  static String growthAssessmentsByChild(String childId) =>
      '/mobile/growth/assessments/child/$childId';

  // ---- Q&A (/mobile/qa/*) ----
  static const String qaQuestions = '/mobile/qa/questions';
  // Same path as [qaQuestions], used with POST to submit a new question
  // (the asker is derived server-side from the JWT) instead of GET to list.
  static const String qaAskQuestion = '/mobile/qa/questions';
  static String qaQuestionAnswer(String id) => '/mobile/qa/questions/$id/answer';
  static const String qaFaqs = '/mobile/qa/faqs';
  static const String qaQuestionnaires = '/mobile/qa/questionnaires';
  static const String qaCategories = '/mobile/qa/categories';

  // ---- Notifications (/mobile/notifications/*) ----
  static const String notifications = '/mobile/notifications';
  static String notificationMarkRead(String id) =>
      '/mobile/notifications/$id/read';

  // NOTE: Deliberately no constants for booking, chatbot/AI, analytics
  // (mobile), or health-intel — no gateway route (booking/chat/mobile
  // analytics) or no controller (health-intel) exists behind them. Adding
  // constants for these would produce screens that silently 404. Those
  // features are shown as disabled/"coming soon" instead — see
  // lib/feature/booking and the chatbot FAB.
}
