part of 'emergency_cubit.dart';

enum EmergencyStatus { initial, loading, loaded, error }

class EmergencyState extends Equatable {
  final EmergencyStatus status;
  final List<EmergencyTipModel> tips;
  final String? errorMessage;

  const EmergencyState({
    required this.status,
    this.tips = const [],
    this.errorMessage,
  });

  const EmergencyState.initial() : this(status: EmergencyStatus.initial);

  EmergencyState copyWith({
    EmergencyStatus? status,
    List<EmergencyTipModel>? tips,
    String? errorMessage,
  }) =>
      EmergencyState(
        status: status ?? this.status,
        tips: tips ?? this.tips,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, tips, errorMessage];
}
