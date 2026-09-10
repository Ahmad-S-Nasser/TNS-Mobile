part of 'hospitals_cubit.dart';

enum HospitalsStatus { initial, loading, loaded, error }

class HospitalsState extends Equatable {
  final HospitalsStatus status;
  final List<HospitalModel> hospitals;
  final HospitalModel? selectedHospital;
  final String? errorMessage;

  const HospitalsState({
    required this.status,
    this.hospitals = const [],
    this.selectedHospital,
    this.errorMessage,
  });

  const HospitalsState.initial() : this(status: HospitalsStatus.initial);

  HospitalsState copyWith({
    HospitalsStatus? status,
    List<HospitalModel>? hospitals,
    HospitalModel? selectedHospital,
    String? errorMessage,
  }) =>
      HospitalsState(
        status: status ?? this.status,
        hospitals: hospitals ?? this.hospitals,
        selectedHospital: selectedHospital ?? this.selectedHospital,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, hospitals, selectedHospital, errorMessage];
}
