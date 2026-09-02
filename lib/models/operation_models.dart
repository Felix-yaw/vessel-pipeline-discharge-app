/// The lifecycle stages of a discharge operation.
///
/// Mirrors the state machine defined in the Technical Requirement Document:
/// Idle -> Setup -> Initialized -> Active (with Halt/Resume interruptions)
/// -> Completed (returns to Idle).
enum OperationState {
  /// No operation in progress. Home shows "No Operation Assigned".
  idle,

  /// Jetty checklist details entered; checklist pending validation.
  setup,

  /// Initial tank farm readings submitted; waiting to start discharge.
  initialized,

  /// Discharge running; hourly readings and halt/final actions available.
  active,

  /// Discharge paused by the operator.
  halted,
}

/// A single set of flow-meter readings captured during an active operation.
///
/// Also satisfies the `HourlyReadingData` type referenced by the existing
/// `ChecklistSummaryScreen`.
class HourlyReadingData {
  final int hour;
  final String flowRate;
  final String tankLevelA;
  final String tankLevelB;
  final String totalDischarge;
  final String remainingOnBoard;

  const HourlyReadingData({
    required this.hour,
    this.flowRate = '',
    this.tankLevelA = '',
    this.tankLevelB = '',
    this.totalDischarge = '',
    this.remainingOnBoard = '',
  });
}

/// Domain object holding the state of the current discharge operation.
class Operation {
  String vesselName;
  String vesselType;
  String vesselCode;

  String jettyStatus;
  String boosterStatus;
  String tankStatus;

  bool checklistCompleted;
  String initialFlowMeterReading;
  String finalFlowMeterReading;

  DateTime? startedAt;
  DateTime? initialCheckCompletedAt;
  DateTime? lastReadingAt;
  DateTime? completedAt;

  final List<HourlyReadingData> hourlyReadings;

  Operation({
    this.vesselName = '',
    this.vesselType = '',
    this.vesselCode = 'VES 101203',
    this.jettyStatus = 'Inactive',
    this.boosterStatus = 'Inactive',
    this.tankStatus = 'Inactive',
    this.checklistCompleted = false,
    this.initialFlowMeterReading = '',
    this.finalFlowMeterReading = '',
    this.startedAt,
    this.initialCheckCompletedAt,
    this.lastReadingAt,
    this.completedAt,
    List<HourlyReadingData>? hourlyReadings,
  }) : hourlyReadings = hourlyReadings ?? [];
}
