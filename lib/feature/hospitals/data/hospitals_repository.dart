import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/hospitals/data/model/hospital_model.dart';

/// Thin wrapper over the Content service's section-filtered endpoint
/// (`section=Hospitals`) plus single-item lookup for the detail screen.
class HospitalsRepository {
  final ApiClient _client;

  HospitalsRepository(this._client);

  Future<List<HospitalModel>> getHospitals() async {
    final data = await _client.get(ApiConstants.contentBySection('Hospitals'));
    final items = _extractList(data);
    return [
      for (var i = 0; i < items.length; i++)
        HospitalModel.fromJson(items[i] as Map<String, dynamic>, index: i),
    ];
  }

  Future<HospitalModel> getHospitalById(String id) async {
    final data = await _client.get(ApiConstants.contentById(id)) as Map<String, dynamic>;
    return HospitalModel.fromJson(data);
  }

  List<dynamic> _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['data'] ?? data['content'];
      if (items is List) return items;
    }
    return const [];
  }
}
