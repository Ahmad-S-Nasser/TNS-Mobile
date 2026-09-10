part of 'assessment_cubit.dart';

enum AsyncStatus { initial, loading, loaded, error }

class AssessmentState extends Equatable {
  final AsyncStatus childrenStatus;
  final List<ChildOption> children;
  final ChildOption? selectedChild;

  final AsyncStatus ageGroupsStatus;
  final List<AgeGroupModel> ageGroups;
  final AgeGroupModel? resolvedAgeGroup;

  final AsyncStatus fieldsStatus;
  final List<GrowthFieldModel> fields;

  final AsyncStatus fieldDetailStatus;
  final GrowthFieldModel? selectedField;

  final Map<String, SkillResponseInput> responses;

  final AsyncStatus submitStatus;
  final AssessmentResult? result;

  final AsyncStatus historyStatus;
  final List<AssessmentHistoryEntry> history;

  final String? errorMessage;

  const AssessmentState({
    this.childrenStatus = AsyncStatus.initial,
    this.children = const [],
    this.selectedChild,
    this.ageGroupsStatus = AsyncStatus.initial,
    this.ageGroups = const [],
    this.resolvedAgeGroup,
    this.fieldsStatus = AsyncStatus.initial,
    this.fields = const [],
    this.fieldDetailStatus = AsyncStatus.initial,
    this.selectedField,
    this.responses = const {},
    this.submitStatus = AsyncStatus.initial,
    this.result,
    this.historyStatus = AsyncStatus.initial,
    this.history = const [],
    this.errorMessage,
  });

  AssessmentState copyWith({
    AsyncStatus? childrenStatus,
    List<ChildOption>? children,
    ChildOption? selectedChild,
    AsyncStatus? ageGroupsStatus,
    List<AgeGroupModel>? ageGroups,
    AgeGroupModel? resolvedAgeGroup,
    AsyncStatus? fieldsStatus,
    List<GrowthFieldModel>? fields,
    AsyncStatus? fieldDetailStatus,
    GrowthFieldModel? selectedField,
    Map<String, SkillResponseInput>? responses,
    AsyncStatus? submitStatus,
    AssessmentResult? result,
    AsyncStatus? historyStatus,
    List<AssessmentHistoryEntry>? history,
    String? errorMessage,
  }) =>
      AssessmentState(
        childrenStatus: childrenStatus ?? this.childrenStatus,
        children: children ?? this.children,
        selectedChild: selectedChild ?? this.selectedChild,
        ageGroupsStatus: ageGroupsStatus ?? this.ageGroupsStatus,
        ageGroups: ageGroups ?? this.ageGroups,
        resolvedAgeGroup: resolvedAgeGroup ?? this.resolvedAgeGroup,
        fieldsStatus: fieldsStatus ?? this.fieldsStatus,
        fields: fields ?? this.fields,
        fieldDetailStatus: fieldDetailStatus ?? this.fieldDetailStatus,
        selectedField: selectedField ?? this.selectedField,
        responses: responses ?? this.responses,
        submitStatus: submitStatus ?? this.submitStatus,
        result: result ?? this.result,
        historyStatus: historyStatus ?? this.historyStatus,
        history: history ?? this.history,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [
        childrenStatus,
        children,
        selectedChild,
        ageGroupsStatus,
        ageGroups,
        resolvedAgeGroup,
        fieldsStatus,
        fields,
        fieldDetailStatus,
        selectedField,
        responses,
        submitStatus,
        result,
        historyStatus,
        history,
        errorMessage,
      ];
}
