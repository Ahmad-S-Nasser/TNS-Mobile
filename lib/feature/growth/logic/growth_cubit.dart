import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/growth/data/growth_repository.dart';
import 'package:tips_n_steps/feature/growth/data/model/growth_field_model.dart';

part 'growth_state.dart';

/// Drives the Growth Fields browsing screens (list + detail). The
/// assessment/checklist flow has its own [AssessmentCubit] since it's a
/// materially different flow (child + age group + submission), not just
/// browsing informational content.
class GrowthCubit extends Cubit<GrowthState> {
  final GrowthRepository _repository;

  GrowthCubit(this._repository) : super(const GrowthState());

  Future<void> loadFields() async {
    emit(state.copyWith(fieldsStatus: GrowthStatus.loading));
    try {
      final fields = await _repository.getFields();
      emit(state.copyWith(fieldsStatus: GrowthStatus.loaded, fields: fields));
    } on AppException catch (e) {
      emit(state.copyWith(
        fieldsStatus: GrowthStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<void> selectField(String id) async {
    emit(state.copyWith(detailStatus: GrowthStatus.loading));
    try {
      final detail = await _repository.getFieldById(id);
      emit(state.copyWith(
        detailStatus: GrowthStatus.loaded,
        selectedField: detail,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        detailStatus: GrowthStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  void clearSelection() =>
      emit(state.copyWith(detailStatus: GrowthStatus.initial));
}
