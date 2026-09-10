part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, saving, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user;
  final String? errorMessage;
  final bool saveSucceeded;

  const ProfileState({
    required this.status,
    this.user,
    this.errorMessage,
    this.saveSucceeded = false,
  });

  const ProfileState.initial() : this(status: ProfileStatus.initial);

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    String? errorMessage,
    bool saveSucceeded = false,
  }) =>
      ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
        saveSucceeded: saveSucceeded,
      );

  @override
  List<Object?> get props => [status, user, errorMessage, saveSucceeded];
}
