import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

/// Thin wrapper over the Content service's section-filtered endpoint.
/// `HealthUnits` and `Vaccines` are two distinct confirmed `ContentSection`
/// enum values — the general clinic/unit listing maps to `HealthUnits`, and
/// the vaccination-schedule screen (whose hardcoded content was clearly
/// vaccine-by-age data) maps to `Vaccines`.
class HealthUnitsRepository {
  final ApiClient _client;

  HealthUnitsRepository(this._client);

  Future<List<HealthUnitModel>> getHealthUnits() async {
    final data = await _client.get(ApiConstants.contentBySection('HealthUnits'));
    final items = _extractList(data);
    return [
      for (var i = 0; i < items.length; i++)
        HealthUnitModel.fromJson(items[i] as Map<String, dynamic>, index: i),
    ];
  }

  Future<List<VaccinationItem>> getVaccinationSchedule() async {
    final data = await _client.get(ApiConstants.contentBySection('Vaccines'));
    final items = _extractList(data)
        .map((e) => VaccinationItem.fromJson(e as Map<String, dynamic>))
        .toList();
    items.sort((a, b) => (a.minAgeMonths ?? 0).compareTo(b.minAgeMonths ?? 0));
    return items;
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
