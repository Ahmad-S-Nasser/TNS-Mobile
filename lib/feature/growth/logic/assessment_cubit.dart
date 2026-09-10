import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/auth/data/auth_repository.dart';
import 'package:tips_n_steps/feature/growth/data/growth_repository.dart';
import 'package:tips_n_steps/feature/growth/data/model/age_group_model.dart';
import 'package:tips_n_steps/feature/growth/data/model/assessment_model.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

part 'assessment_state.dart';

/// Drives the milestone-checklist assessment flow: pick a child, resolve
/// their current age group, pick a developmental field, answer each of its
/// skills with the input matching that skill's real metric type (Boolean /
/// Numeric / Scale), submit, and browse history. This replaced the
/// prototype's fake weight/height/head form — the backend has no physical
/// measurement endpoint, only this milestone-checklist model.
class AssessmentCubit extends Cubit<AssessmentState> {
  final GrowthRepository _repository;
  final AuthRepository _authRepository;

  AssessmentCubit(this._repository, this._authRepository)
      : super(const AssessmentState());

  Future<void> loadChildren() async {
    emit(state.copyWith(childrenStatus: AsyncStatus.loading));
    try {
      final children = await _repository.getChildren();
      emit(state.copyWith(
        childrenStatus: AsyncStatus.loaded,
        children: children,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        childrenStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<void> selectChild(ChildOption child) async {
    emit(state.copyWith(selectedChild: child));
    await _resolveAgeGroup();
  }

  Future<void> _resolveAgeGroup() async {
    emit(state.copyWith(ageGroupsStatus: AsyncStatus.loading));
    try {
      final ageGroups = state.ageGroups.isNotEmpty
          ? state.ageGroups
          : await _repository.getAgeGroups();
      final child = state.selectedChild;
      AgeGroupModel? resolved;
      if (child != null) {
        final ageInMonths = child.ageInMonths;
        for (final g in ageGroups) {
          if (g.covers(ageInMonths)) {
            resolved = g;
            break;
          }
        }
      }
      emit(state.copyWith(
        ageGroupsStatus: AsyncStatus.loaded,
        ageGroups: ageGroups,
        resolvedAgeGroup: resolved,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        ageGroupsStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<void> loadFields() async {
    emit(state.copyWith(fieldsStatus: AsyncStatus.loading));
    try {
      final fields = await _repository.getFields();
      emit(state.copyWith(fieldsStatus: AsyncStatus.loaded, fields: fields));
    } on AppException catch (e) {
      emit(state.copyWith(
        fieldsStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<void> selectField(String id) async {
    emit(state.copyWith(fieldDetailStatus: AsyncStatus.loading, responses: {}));
    try {
      final detail = await _repository.getFieldById(id);
      emit(state.copyWith(
        fieldDetailStatus: AsyncStatus.loaded,
        selectedField: detail,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        fieldDetailStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  void setBooleanResponse(String skillId, bool value) {
    final updated = Map<String, SkillResponseInput>.from(state.responses);
    updated[skillId] = SkillResponseInput(skillId: skillId, yesNoValue: value);
    emit(state.copyWith(responses: updated));
  }

  void setNumericResponse(String skillId, double value) {
    final updated = Map<String, SkillResponseInput>.from(state.responses);
    updated[skillId] = SkillResponseInput(skillId: skillId, numericValue: value);
    emit(state.copyWith(responses: updated));
  }

  bool get isChecklistComplete {
    final skills = state.selectedField?.skills ?? const [];
    if (skills.isEmpty) return false;
    return skills.every((s) => state.responses.containsKey(s.id));
  }

  Future<bool> submit() async {
    final child = state.selectedChild;
    final ageGroup = state.resolvedAgeGroup;
    if (child == null || ageGroup == null) {
      emit(state.copyWith(
        submitStatus: AsyncStatus.error,
        errorMessage: 'يرجى اختيار الطفل أولاً',
      ));
      return false;
    }
    if (!isChecklistComplete) {
      emit(state.copyWith(
        submitStatus: AsyncStatus.error,
        errorMessage: 'يرجى الإجابة عن جميع المهارات قبل الحفظ',
      ));
      return false;
    }

    emit(state.copyWith(submitStatus: AsyncStatus.loading));
    try {
      final parentId = await _authRepository.currentUserId() ?? '';
      final result = await _repository.submitAssessment(
        childId: child.id,
        parentId: parentId,
        ageGroupId: ageGroup.id,
        responses: state.responses.values.toList(),
      );
      emit(state.copyWith(submitStatus: AsyncStatus.loaded, result: result));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(
        submitStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
      return false;
    }
  }

  Future<void> loadHistory(String childId) async {
    emit(state.copyWith(historyStatus: AsyncStatus.loading));
    try {
      final history = await _repository.getAssessmentHistory(childId);
      emit(state.copyWith(historyStatus: AsyncStatus.loaded, history: history));
    } on AppException catch (e) {
      emit(state.copyWith(
        historyStatus: AsyncStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }
}
