import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/profile/data/model/user_model.dart';
import 'package:tips_n_steps/feature/profile/data/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState.initial());

  Future<void> loadMe() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _repository.getMe();
      emit(state.copyWith(status: ProfileStatus.loaded, user: user));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.userMessage,
      ));
    }
  }

  Future<bool> save({
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    emit(state.copyWith(status: ProfileStatus.saving, saveSucceeded: false));
    try {
      await _repository.updateMe(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        preferredLanguage: state.user?.preferredLanguage ?? 'ar',
      );
      final refreshed = await _repository.getMe();
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        user: refreshed,
        saveSucceeded: true,
      ));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        errorMessage: e.userMessage,
      ));
      return false;
    }
  }
}
