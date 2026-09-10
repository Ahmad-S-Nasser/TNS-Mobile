import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/health_units/data/health_units_repository.dart';
import 'package:tips_n_steps/feature/health_units/data/model/health_unit_model.dart';

part 'health_units_state.dart';

/// One cubit backs both screens under this feature (the general units list
/// and the vaccination schedule) since `HealthUnitsView` inline-swaps between
/// them without a route push, mirroring the existing pattern used elsewhere
/// (e.g. `GrowthFieldsView`).
class HealthUnitsCubit extends Cubit<HealthUnitsState> {
  final HealthUnitsRepository _repository;

  HealthUnitsCubit(this._repository) : super(const HealthUnitsState.initial());

  Future<void> loadUnits() async {
    emit(state.copyWith(unitsStatus: HealthUnitsStatus.loading));
    try {
      final units = await _repository.getHealthUnits();
      emit(state.copyWith(unitsStatus: HealthUnitsStatus.loaded, units: units));
    } on AppException catch (e) {
      emit(state.copyWith(
        unitsStatus: HealthUnitsStatus.error,
        unitsError: e.userMessage,
      ));
    }
  }

  Future<void> loadSchedule() async {
    emit(state.copyWith(scheduleStatus: HealthUnitsStatus.loading));
    try {
      final schedule = await _repository.getVaccinationSchedule();
      emit(state.copyWith(
        scheduleStatus: HealthUnitsStatus.loaded,
        schedule: schedule,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        scheduleStatus: HealthUnitsStatus.error,
        scheduleError: e.userMessage,
      ));
    }
  }
}
