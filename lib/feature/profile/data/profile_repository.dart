import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/profile/data/model/user_model.dart';

class ProfileRepository {
  final ApiClient _client;

  ProfileRepository(this._client);

  Future<UserModel> getMe() async {
    final data = await _client.get(ApiConstants.usersMe) as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  /// Backend PUT body only accepts these four fields — email is not
  /// editable via this endpoint. Deliberately doesn't try to parse the PUT
  /// response as a [UserModel] (its exact shape isn't guaranteed to match
  /// GET) — callers should re-fetch via [getMe] after a successful update.
  Future<void> updateMe({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String preferredLanguage,
  }) {
    return _client.put(ApiConstants.usersMe, body: {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'preferredLanguage': preferredLanguage,
    });
  }
}
