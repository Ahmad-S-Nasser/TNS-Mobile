import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/children/data/children_repository.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';

part 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  final ChildrenRepository _repository;

  ChildrenCubit(this._repository) : super(const ChildrenState.initial());

  Future<void> loadChildren() async {
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      final children = await _repository.getMyChildren();
      emit(state.copyWith(status: ChildrenStatus.loaded, children: children));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: ChildrenStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<bool> addChild({
    required String fullName,
    required DateTime dateOfBirth,
    required String gender,
    String? bloodType,
  }) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await _repository.createChild(
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bloodType: bloodType,
      );
      await _refreshAfterAction();
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(errorMessage: e.userMessage));
      return false;
    }
  }

  Future<bool> updateChild({
    required String id,
    required String fullName,
    required DateTime dateOfBirth,
    required String gender,
    String? bloodType,
  }) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await _repository.updateChild(
        id: id,
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bloodType: bloodType,
      );
      await _refreshAfterAction();
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(errorMessage: e.userMessage));
      return false;
    }
  }

  Future<bool> deleteChild(String id) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await _repository.deleteChild(id);
      await _refreshAfterAction();
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(errorMessage: e.userMessage));
      return false;
    }
  }

  /// Re-fetch as source of truth (same pattern as `ProfileCubit.save`)
  /// rather than patching local state after a create/update/delete.
  Future<void> _refreshAfterAction() async {
    final children = await _repository.getMyChildren();
    emit(state.copyWith(
      status: ChildrenStatus.loaded,
      children: children,
      actionSucceeded: true,
    ));
  }
}
