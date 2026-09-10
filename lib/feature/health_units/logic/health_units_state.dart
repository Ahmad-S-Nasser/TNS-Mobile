part of 'health_units_cubit.dart';

enum HealthUnitsStatus { initial, loading, loaded, error }

class HealthUnitsState extends Equatable {
  final HealthUnitsStatus unitsStatus;
  final List<HealthUnitModel> units;
  final String? unitsError;
  final HealthUnitsStatus scheduleStatus;
  final List<VaccinationItem> schedule;
  final String? scheduleError;

  const HealthUnitsState({
    required this.unitsStatus,
    this.units = const [],
    this.unitsError,
    required this.scheduleStatus,
    this.schedule = const [],
    this.scheduleError,
  });

  const HealthUnitsState.initial()
      : this(
          unitsStatus: HealthUnitsStatus.initial,
          scheduleStatus: HealthUnitsStatus.initial,
        );

  HealthUnitsState copyWith({
    HealthUnitsStatus? unitsStatus,
    List<HealthUnitModel>? units,
    String? unitsError,
    HealthUnitsStatus? scheduleStatus,
    List<VaccinationItem>? schedule,
    String? scheduleError,
  }) =>
      HealthUnitsState(
        unitsStatus: unitsStatus ?? this.unitsStatus,
        units: units ?? this.units,
        unitsError: unitsError,
        scheduleStatus: scheduleStatus ?? this.scheduleStatus,
        schedule: schedule ?? this.schedule,
        scheduleError: scheduleError,
      );

  @override
  List<Object?> get props => [
        unitsStatus,
        units,
        unitsError,
        scheduleStatus,
        schedule,
        scheduleError,
      ];
}
