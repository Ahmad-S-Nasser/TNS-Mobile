import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';

class ChildrenRepository {
  final ApiClient _client;

  ChildrenRepository(this._client);

  Future<List<ChildModel>> getMyChildren() async {
    final data = await _client.get(ApiConstants.children);
    final list = data is List
        ? data
        : (data is Map ? (data['items'] ?? data['data'] ?? []) : []);
    return (list as List)
        .map((e) => ChildModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ChildModel> createChild({
    required String fullName,
    required DateTime dateOfBirth,
    required String gender,
    String? bloodType,
  }) async {
    final data = await _client.post(ApiConstants.children, body: {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      if (bloodType != null && bloodType.isNotEmpty) 'bloodType': bloodType,
    });
    return ChildModel.fromJson(data as Map<String, dynamic>);
  }

  Future<ChildModel> updateChild({
    required String id,
    required String fullName,
    required DateTime dateOfBirth,
    required String gender,
    String? bloodType,
  }) async {
    final data = await _client.put(ApiConstants.childById(id), body: {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      if (bloodType != null && bloodType.isNotEmpty) 'bloodType': bloodType,
    });
    return ChildModel.fromJson(data as Map<String, dynamic>);
  }

  Future<void> deleteChild(String id) {
    return _client.delete(ApiConstants.childById(id));
  }
}
