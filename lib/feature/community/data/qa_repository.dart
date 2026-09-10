import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';

/// Thin wrapper around `GET /mobile/qa/categories` — `{id,name,label}`.
/// `name` is the enum name backend expects back as `category` on
/// `POST /mobile/qa/questions` (e.g. "General", "Growth").
class QaCategoryModel {
  final int id;
  final String name;
  final String label;

  const QaCategoryModel({
    required this.id,
    required this.name,
    required this.label,
  });

  factory QaCategoryModel.fromJson(Map<String, dynamic> json) =>
      QaCategoryModel(
        id: int.tryParse('${json['id']}') ?? 0,
        name: json['name']?.toString() ?? '',
        label: json['label']?.toString() ?? json['name']?.toString() ?? '',
      );
}

/// Static fallback mirroring the backend's `QACategory` enum
/// (`TNS backend/.../QA.Domain/Enums/QACategory.cs`) and its Arabic/English
/// labels, used until/unless `GET /mobile/qa/categories` responds — the ask
/// form needs a category to preselect immediately rather than blocking on a
/// network round trip.
const List<QaCategoryModel> qaFallbackCategories = [
  QaCategoryModel(id: 1, name: 'General', label: 'عام / General'),
  QaCategoryModel(id: 2, name: 'Nutrition', label: 'تغذية / Nutrition'),
  QaCategoryModel(id: 3, name: 'Growth', label: 'نمو / Growth'),
  QaCategoryModel(id: 4, name: 'Behavioral', label: 'سلوك / Behavioral'),
  QaCategoryModel(id: 5, name: 'Health', label: 'صحة / Health'),
  QaCategoryModel(id: 6, name: 'Education', label: 'تعليم / Education'),
  QaCategoryModel(
    id: 7,
    name: 'SexualEducation',
    label: 'التربية الجنسية / Sexual Education',
  ),
  QaCategoryModel(id: 8, name: 'Vaccines', label: 'لقاحات / Vaccines'),
  QaCategoryModel(id: 9, name: 'Emergency', label: 'طوارئ / Emergency'),
];

class QaRepository {
  final ApiClient _client;

  QaRepository(this._client);

  /// `GET /mobile/qa/questions` — the raw `Question` entity list. There is
  /// no `GET /mobile/qa/questions/{id}`, so a single question is looked up
  /// by filtering this list client-side (see [QaCubit]).
  Future<List<QuestionModel>> getQuestions() async {
    final data = await _client.get(ApiConstants.qaQuestions);
    final list = data is List ? data : const [];
    return list
        .whereType<Map>()
        .map((e) => QuestionModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// `POST /mobile/qa/questions` — the asker (`parentId`) is derived
  /// server-side from the JWT, not sent in the body.
  Future<void> askQuestion({
    required String category,
    required String questionTextAr,
    String? questionTextEn,
    bool isAnonymous = false,
  }) {
    return _client.post(ApiConstants.qaAskQuestion, body: {
      'category': category,
      'questionTextAr': questionTextAr,
      if (questionTextEn != null && questionTextEn.isNotEmpty)
        'questionTextEn': questionTextEn,
      'isAnonymous': isAnonymous,
    });
  }

  /// `POST /mobile/qa/questions/{id}/answer` — body `{doctorId, answerText}`
  /// per `AnswerRequest` in `QAController.cs`.
  Future<void> answerQuestion({
    required String questionId,
    required String doctorId,
    required String answerText,
  }) {
    return _client.post(ApiConstants.qaQuestionAnswer(questionId), body: {
      'doctorId': doctorId,
      'answerText': answerText,
    });
  }

  /// `GET /mobile/qa/faqs?categoryId=` — kept close to the raw shape since
  /// no mobile screen consumes FAQs yet.
  Future<List<Map<String, dynamic>>> getFaqs({int? categoryId}) async {
    final data = await _client.get(
      ApiConstants.qaFaqs,
      query: categoryId != null ? {'categoryId': categoryId} : null,
    );
    final list = data is List ? data : const [];
    return list.whereType<Map>().map(Map<String, dynamic>.from).toList();
  }

  /// `GET /mobile/qa/questionnaires` — no mobile screen consumes this yet.
  Future<List<Map<String, dynamic>>> getQuestionnaires() async {
    final data = await _client.get(ApiConstants.qaQuestionnaires);
    final list = data is List ? data : const [];
    return list.whereType<Map>().map(Map<String, dynamic>.from).toList();
  }

  /// `GET /mobile/qa/categories` — feeds the ask-a-question category picker.
  Future<List<QaCategoryModel>> getCategories() async {
    final data = await _client.get(ApiConstants.qaCategories);
    final list = data is List ? data : const [];
    return list
        .whereType<Map>()
        .map((e) => QaCategoryModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
