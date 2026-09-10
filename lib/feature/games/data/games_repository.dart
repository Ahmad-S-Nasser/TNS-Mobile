import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/games/data/model/game_model.dart';

/// Thin wrapper over the Content service's section-filtered endpoint
/// (`section=EducationalGames`) plus single-item lookup for the detail /
/// PDF-preview screens.
class GamesRepository {
  final ApiClient _client;

  GamesRepository(this._client);

  Future<List<GameModel>> getGames() async {
    final data = await _client.get(ApiConstants.contentBySection('EducationalGames'));
    final items = _extractList(data);
    return [
      for (var i = 0; i < items.length; i++)
        GameModel.fromJson(items[i] as Map<String, dynamic>, index: i),
    ];
  }

  Future<GameModel> getGameById(String id) async {
    final data = await _client.get(ApiConstants.contentById(id)) as Map<String, dynamic>;
    return GameModel.fromJson(data);
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
