part of 'growth_cubit.dart';

enum GrowthStatus { initial, loading, loaded, error }

class GrowthState extends Equatable {
  final GrowthStatus fieldsStatus;
  final List<GrowthFieldModel> fields;
  final GrowthStatus detailStatus;
  final GrowthFieldModel? selectedField;
  final String? errorMessage;

  const GrowthState({
    this.fieldsStatus = GrowthStatus.initial,
    this.fields = const [],
    this.detailStatus = GrowthStatus.initial,
    this.selectedField,
    this.errorMessage,
  });

  GrowthState copyWith({
    GrowthStatus? fieldsStatus,
    List<GrowthFieldModel>? fields,
    GrowthStatus? detailStatus,
    GrowthFieldModel? selectedField,
    String? errorMessage,
  }) =>
      GrowthState(
        fieldsStatus: fieldsStatus ?? this.fieldsStatus,
        fields: fields ?? this.fields,
        detailStatus: detailStatus ?? this.detailStatus,
        selectedField: selectedField ?? this.selectedField,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props =>
      [fieldsStatus, fields, detailStatus, selectedField, errorMessage];
}
