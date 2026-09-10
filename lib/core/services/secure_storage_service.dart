import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the auth session (JWT + identity) in the platform secure store.
/// Per the backend integration guide: never use SharedPreferences for the
/// token.
class SecureStorageService {
  static const _keyToken = 'tns_token';
  static const _keyUserId = 'tns_user_id';
  static const _keyRole = 'tns_role';
  static const _keyEmail = 'tns_email';

  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveSession({
    required String token,
    required String userId,
    required String role,
    required String email,
  }) async {
    await Future.wait([
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyUserId, value: userId),
      _storage.write(key: _keyRole, value: role),
      _storage.write(key: _keyEmail, value: email),
    ]);
  }

  Future<String?> readToken() => _storage.read(key: _keyToken);

  Future<String?> readUserId() => _storage.read(key: _keyUserId);

  Future<String?> readRole() => _storage.read(key: _keyRole);

  Future<String?> readEmail() => _storage.read(key: _keyEmail);

  Future<bool> hasSession() async => (await readToken()) != null;

  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(key: _keyToken),
      _storage.delete(key: _keyUserId),
      _storage.delete(key: _keyRole),
      _storage.delete(key: _keyEmail),
    ]);
  }
}
