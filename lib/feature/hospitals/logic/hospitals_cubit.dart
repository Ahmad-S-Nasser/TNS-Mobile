import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/hospitals/data/hospitals_repository.dart';
import 'package:tips_n_steps/feature/hospitals/data/model/hospital_model.dart';

part 'hospitals_state.dart';

class HospitalsCubit extends Cubit<HospitalsState> {
  final HospitalsRepository _repository;

  HospitalsCubit(this._repository) : super(const HospitalsState.initial());

  Future<void> loadHospitals() async {
    emit(state.copyWith(status: HospitalsStatus.loading));
    try {
      final hospitals = await _repository.getHospitals();
      emit(state.copyWith(status: HospitalsStatus.loaded, hospitals: hospitals));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: HospitalsStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<void> loadHospitalById(String id) async {
    emit(state.copyWith(status: HospitalsStatus.loading));
    try {
      final hospital = await _repository.getHospitalById(id);
      emit(state.copyWith(
        status: HospitalsStatus.loaded,
        selectedHospital: hospital,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: HospitalsStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }
}
