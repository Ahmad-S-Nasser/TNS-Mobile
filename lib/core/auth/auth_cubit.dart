import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/auth/data/auth_repository.dart';

part 'auth_state.dart';

/// Single source of truth for whether the app is authenticated. Gates
/// routing at splash, and is force-flipped to unauthenticated by
/// [ApiClient.onUnauthorized] (wired in service_locator.dart) whenever any
/// request comes back 401, so an expired token logs the user out from
/// wherever they are in the app.
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(const AuthState.unknown());

  Future<void> checkSession() async {
    final hasSession = await _repository.hasSession();
    if (!hasSession) {
      emit(const AuthState.unauthenticated());
      return;
    }
    final userId = await _repository.currentUserId();
    final email = await _repository.currentEmail();
    final role = await _repository.currentRole();
    if (userId == null || userId.isEmpty) {
      emit(const AuthState.unauthenticated());
      return;
    }
    emit(AuthState.authenticated(
      userId: userId,
      email: email ?? '',
      role: role ?? '',
    ));
  }

  Future<bool> login(String email, String password) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      final result = await _repository.login(email, password);
      emit(AuthState.authenticated(
        userId: result.userId,
        email: result.email,
        role: result.role,
      ));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.userMessage));
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      final result = await _repository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      emit(AuthState.authenticated(
        userId: result.userId,
        email: result.email,
        role: result.role,
      ));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.userMessage));
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(const AuthState.unauthenticated());
  }

  /// Invoked by [ApiClient.onUnauthorized] — a 401 from any request means
  /// the token is dead server-side, so clear local session and drop the
  /// user back to login without waiting for them to hit logout themselves.
  void forceLogout() {
    _repository.logout();
    emit(const AuthState.unauthenticated(
      errorMessage: 'انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى',
    ));
  }
}
