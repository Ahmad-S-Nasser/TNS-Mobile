import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';

/// Envelope returned by `GET /mobile/content`: `{items, totalCount, page,
/// pageSize}`.
class ContentListResult {
  final List<ContentItem> items;
  final int totalCount;
  final int page;
  final int pageSize;

  const ContentListResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });
}

class ContentRepository {
  final ApiClient _client;

  ContentRepository(this._client);

  Future<List<ContentSection>> getSections() async {
    final data = await _client.get(ApiConstants.contentSections);
    final list = data is List ? data : (data as Map)['items'] ?? [];
    return (list as List)
        .map((e) => ContentSection.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ContentListResult> list({
    int? sectionId,
    String? section,
    String lang = 'ar',
    int page = 1,
    int pageSize = 20,
  }) async {
    final data = await _client.get(ApiConstants.content, query: {
      'lang': lang,
      'page': page,
      'pageSize': pageSize,
      if (sectionId != null) 'sectionId': sectionId,
      if (section != null) 'section': section,
    }) as Map<String, dynamic>;

    final items = (data['items'] as List? ?? const [])
        .map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return ContentListResult(
      items: items,
      totalCount: int.tryParse(data['totalCount']?.toString() ?? '') ??
          items.length,
      page: int.tryParse(data['page']?.toString() ?? '') ?? page,
      pageSize: int.tryParse(data['pageSize']?.toString() ?? '') ?? pageSize,
    );
  }

  Future<ContentItem> getById(String id, {String lang = 'ar'}) async {
    final data = await _client
        .get(ApiConstants.contentById(id), query: {'lang': lang}) as Map<String, dynamic>;
    return ContentItem.fromJson(data);
  }
}
