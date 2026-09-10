import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/core/services/secure_storage_service.dart';

/// Roles as returned by the backend's single `role` string claim.
class UserRoles {
  static const parent = 'Parent';
  static const doctor = 'Doctor';
  static const admin = 'Admin';
  static const superAdmin = 'SuperAdmin';
}

class AuthResult {
  final String userId;
  final String email;
  final String role;

  const AuthResult({required this.userId, required this.email, required this.role});
}

/// Wraps the real auth endpoints. Login is at `/auth/login` (NOT
/// `/mobile/auth/login` — the gateway has no such route). Registration is at
/// `/mobile/users/register` and does not return a token, so the integration
/// guide's flow is: register, then immediately log in.
class AuthRepository {
  final ApiClient _client;
  final SecureStorageService _storage;

  AuthRepository(this._client, this._storage);

  Future<AuthResult> login(String email, String password) async {
    final data = await _client.post(
      ApiConstants.authLogin,
      body: {'email': email, 'password': password},
      skipAuth: true,
    ) as Map<String, dynamic>;

    final token = data['token'] as String? ?? '';
    final userId = data['userId'] as String? ?? '';
    final userEmail = data['email'] as String? ?? email;
    final role = data['role'] as String? ?? '';

    await _storage.saveSession(
      token: token,
      userId: userId,
      role: role,
      email: userEmail,
    );

    return AuthResult(userId: userId, email: userEmail, role: role);
  }

  /// Registers a new account, then logs in immediately since `/register`
  /// does not itself return a token (matches the integration guide's
  /// documented onboarding flow).
  Future<AuthResult> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String role = UserRoles.parent,
  }) async {
    await _client.post(
      ApiConstants.usersRegister,
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
      },
      skipAuth: true,
    );

    return login(email, password);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _client.post(ApiConstants.authChangePassword, body: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  /// JWT is stateless — there is no server-side session to invalidate, so
  /// "logout" is purely a local secure-storage clear.
  Future<void> logout() => _storage.clearSession();

  Future<bool> hasSession() => _storage.hasSession();

  Future<String?> currentRole() => _storage.readRole();

  Future<String?> currentUserId() => _storage.readUserId();

  Future<String?> currentEmail() => _storage.readEmail();
}
