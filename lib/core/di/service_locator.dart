import 'package:get_it/get_it.dart';
import 'package:tips_n_steps/core/auth/auth_cubit.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/core/services/secure_storage_service.dart';
import 'package:tips_n_steps/feature/auth/data/auth_repository.dart';
import 'package:tips_n_steps/feature/children/data/children_repository.dart';
import 'package:tips_n_steps/feature/children/logic/children_cubit.dart';
import 'package:tips_n_steps/feature/community/data/qa_repository.dart';
import 'package:tips_n_steps/feature/community/logic/qa_cubit.dart';
import 'package:tips_n_steps/feature/content/data/content_repository.dart';
import 'package:tips_n_steps/feature/content/logic/content_cubit.dart';
import 'package:tips_n_steps/feature/emergency/data/emergency_repository.dart';
import 'package:tips_n_steps/feature/emergency/logic/emergency_cubit.dart';
import 'package:tips_n_steps/feature/games/data/games_repository.dart';
import 'package:tips_n_steps/feature/games/logic/games_cubit.dart';
import 'package:tips_n_steps/feature/growth/data/growth_repository.dart';
import 'package:tips_n_steps/feature/growth/logic/assessment_cubit.dart';
import 'package:tips_n_steps/feature/growth/logic/growth_cubit.dart';
import 'package:tips_n_steps/feature/health_units/data/health_units_repository.dart';
import 'package:tips_n_steps/feature/health_units/logic/health_units_cubit.dart';
import 'package:tips_n_steps/feature/hospitals/data/hospitals_repository.dart';
import 'package:tips_n_steps/feature/hospitals/logic/hospitals_cubit.dart';
import 'package:tips_n_steps/feature/notifications/data/notifications_repository.dart';
import 'package:tips_n_steps/feature/notifications/logic/notifications_cubit.dart';
import 'package:tips_n_steps/feature/profile/data/profile_repository.dart';
import 'package:tips_n_steps/feature/profile/logic/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ---- Core / foundation (Phase 0) ----
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(storage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl<ApiClient>(), sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));

  // Wire the network layer's 401 broadcast to a forced logout, without
  // ApiClient depending on AuthCubit at construction time (would be
  // circular: AuthRepository -> ApiClient, AuthCubit -> AuthRepository).
  sl<ApiClient>().onUnauthorized = () => sl<AuthCubit>().forceLogout();

  // ---- Profile (Phase 2) ----
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl<ApiClient>()),
  );
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl<ProfileRepository>()));

  // ---- Content (Phase 3) ----
  sl.registerLazySingleton<ContentRepository>(
    () => ContentRepository(sl<ApiClient>()),
  );
  sl.registerFactory<ContentCubit>(() => ContentCubit(sl<ContentRepository>()));

  // ---- Growth (Phase 4) ----
  sl.registerLazySingleton<GrowthRepository>(
    () => GrowthRepository(sl<ApiClient>()),
  );
  sl.registerFactory<GrowthCubit>(() => GrowthCubit(sl<GrowthRepository>()));
  sl.registerFactory<AssessmentCubit>(
    () => AssessmentCubit(sl<GrowthRepository>(), sl<AuthRepository>()),
  );

  // ---- Q&A / Community (Phase 5) ----
  sl.registerLazySingleton<QaRepository>(() => QaRepository(sl<ApiClient>()));
  sl.registerFactory<QaCubit>(() => QaCubit(sl<QaRepository>()));

  // ---- Children (Phase 6) ----
  sl.registerLazySingleton<ChildrenRepository>(
    () => ChildrenRepository(sl<ApiClient>()),
  );
  sl.registerFactory<ChildrenCubit>(
    () => ChildrenCubit(sl<ChildrenRepository>()),
  );

  // ---- Notifications (Phase 7) — app-root singleton, drives the header badge ----
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(sl<ApiClient>()),
  );
  sl.registerLazySingleton<NotificationsCubit>(
    () => NotificationsCubit(sl<NotificationsRepository>()),
  );

  // ---- Emergency (Phase 8) ----
  sl.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepository(sl<ApiClient>()),
  );
  sl.registerFactory<EmergencyCubit>(
    () => EmergencyCubit(sl<EmergencyRepository>()),
  );

  // ---- Health Units / Vaccination (Phase 8) ----
  sl.registerLazySingleton<HealthUnitsRepository>(
    () => HealthUnitsRepository(sl<ApiClient>()),
  );
  sl.registerFactory<HealthUnitsCubit>(
    () => HealthUnitsCubit(sl<HealthUnitsRepository>()),
  );

  // ---- Games (Phase 8) ----
  sl.registerLazySingleton<GamesRepository>(
    () => GamesRepository(sl<ApiClient>()),
  );
  sl.registerFactory<GamesCubit>(() => GamesCubit(sl<GamesRepository>()));

  // ---- Hospitals (Phase 9) ----
  sl.registerLazySingleton<HospitalsRepository>(
    () => HospitalsRepository(sl<ApiClient>()),
  );
  sl.registerFactory<HospitalsCubit>(
    () => HospitalsCubit(sl<HospitalsRepository>()),
  );
}
