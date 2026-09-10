import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/emergency/data/emergency_repository.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  final EmergencyRepository _repository;

  EmergencyCubit(this._repository) : super(const EmergencyState.initial());

  Future<void> loadTips() async {
    emit(state.copyWith(status: EmergencyStatus.loading));
    try {
      final tips = await _repository.getTips();
      emit(state.copyWith(status: EmergencyStatus.loaded, tips: tips));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: EmergencyStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }
}
