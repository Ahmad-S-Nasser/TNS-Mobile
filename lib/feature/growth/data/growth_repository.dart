import 'package:tips_n_steps/core/constants/api_constants.dart';
import 'package:tips_n_steps/core/network/api_client.dart';
import 'package:tips_n_steps/feature/growth/data/model/age_group_model.dart';
import 'package:tips_n_steps/feature/growth/data/model/assessment_model.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

class GrowthRepository {
  final ApiClient _client;

  GrowthRepository(this._client);

  Future<List<GrowthFieldModel>> getFields() async {
    final data = await _client.get(ApiConstants.growthFields) as List;
    return data
        .map((e) => GrowthFieldModel.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  Future<GrowthFieldModel> getFieldById(String id) async {
    final data =
        await _client.get(ApiConstants.growthFieldById(id)) as Map<String, dynamic>;
    return GrowthFieldModel.fromDetailJson(data);
  }

  Future<List<AgeGroupModel>> getAgeGroups() async {
    final data = await _client.get(ApiConstants.growthAgeGroups) as List;
    return data
        .map((e) => AgeGroupModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// The child's own record for the checklist's picker — a minimal,
  /// self-contained fetch (see [ChildOption]) rather than depending on the
  /// separate Children feature's full CRUD model.
  Future<List<ChildOption>> getChildren() async {
    final data = await _client.get(ApiConstants.children) as List;
    return data
        .map((e) => ChildOption.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// The backend's milestone DTO carries [GrowthMilestoneModel.expectedMonth]
  /// but not which age group it belongs to, so the closest age-appropriate
  /// milestone is picked by checking whether its expected month falls
  /// inside the given age group's month range.
  GrowthMilestoneModel? pickMilestoneForAgeGroup(
    List<GrowthMilestoneModel> milestones,
    AgeGroupModel ageGroup,
  ) {
    for (final m in milestones) {
      if (m.expectedMonth >= ageGroup.minAgeMonths &&
          m.expectedMonth <= ageGroup.maxAgeMonths) {
        return m;
      }
    }
    return milestones.isEmpty ? null : milestones.first;
  }

  Future<AssessmentResult> submitAssessment({
    required String childId,
    required String parentId,
    required String ageGroupId,
    required List<SkillResponseInput> responses,
  }) async {
    final data = await _client.post(ApiConstants.growthAssessments, body: {
      'childId': childId,
      'parentId': parentId,
      'ageGroupId': ageGroupId,
      'responses': responses.map((r) => r.toJson()).toList(),
    }) as Map<String, dynamic>;
    return AssessmentResult.fromJson(data);
  }

  Future<List<AssessmentHistoryEntry>> getAssessmentHistory(
      String childId) async {
    final data =
        await _client.get(ApiConstants.growthAssessmentsByChild(childId));
    if (data is! List) return const [];
    return data
        .map((e) => AssessmentHistoryEntry.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => (b.completedAt ?? DateTime(0))
          .compareTo(a.completedAt ?? DateTime(0)));
  }
}
