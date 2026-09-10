import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

/// Thin wrapper over the Content service's section-filtered endpoint
/// (`GET /mobile/content/section/Emergency`). `content_repository.dart` /
/// `ContentItem` (owned by a separate, parallel Phase-3 pass) did not exist
/// yet when this feature was built, so this repository does its own minimal
/// fetch + decode rather than depending on it.
class EmergencyRepository {
  final ApiClient _client;

  EmergencyRepository(this._client);

  Future<List<EmergencyTipModel>> getTips() async {
    final data = await _client.get(ApiConstants.contentBySection('Emergency'));
    final items = _extractList(data);
    return [
      for (var i = 0; i < items.length; i++)
        EmergencyTipModel.fromJson(items[i] as Map<String, dynamic>, index: i),
    ];
  }

  /// Defensive against either a raw JSON array or a `{items:[...]}` /
  /// `{data:[...]}` wrapper — the exact envelope shape of the section
  /// endpoint isn't pinned down in the verified ground truth.
  List<dynamic> _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['data'] ?? data['content'];
      if (items is List) return items;
    }
    return const [];
  }
}
