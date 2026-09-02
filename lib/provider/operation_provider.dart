import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:vessel_pipeline_discharge_app/core/utils/time_utils.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';

/// Central state machine for the discharge operation lifecycle.
///
/// Owns the elapsed ticker and the hourly-reading prompt timer while the
/// operation is active, so the UI can stay stateless and subscribe with
/// `context.select` — only the parts that actually change rebuild.
class OperationProvider extends ChangeNotifier {
  OperationProvider();

  /// How long an operation is expected to take, used for EST. completion.
  static const Duration estimatedDischargeDuration = Duration(hours: 8);

  /// Interval before the app auto-prompts an hourly reading.
  /// Shortened to 30 seconds for demos; set to `Duration(hours: 1)` in prod.
  static const Duration hourlyPromptInterval = Duration(seconds: 30);

  OperationState _state = OperationState.idle;
  Operation _operation = Operation();
  final List<Operation> _completedOperations = [];

  Timer? _ticker;
  Timer? _promptTimer;
  bool _hourlyPromptDue = false;

  OperationState get state => _state;
  Operation get operation => _operation;
  List<Operation> get completedOperations =>
      List.unmodifiable(_completedOperations);
  bool get hourlyPromptDue => _hourlyPromptDue;

  bool get hasActiveOperation =>
      _state == OperationState.setup ||
      _state == OperationState.initialized ||
      _state == OperationState.active ||
      _state == OperationState.halted;

  String get startedText {
    final DateTime? started = _operation.startedAt;
    return started == null ? '--' : formatClock(started);
  }

  String get elapsedText {
    final DateTime? started = _operation.startedAt;
    if (started == null) return '00:00:00';
    return formatElapsed(DateTime.now().difference(started));
  }

  String get estCompletionText {
    final DateTime? started = _operation.startedAt;
    if (started == null) return '--';
    return formatClock(started.add(estimatedDischargeDuration));
  }

  /// Transition: Idle -> Setup.
  void beginSetup({required String vesselName, required String vesselType}) {
    _operation = Operation(vesselName: vesselName, vesselType: vesselType);
    _state = OperationState.setup;
    _syncTimers();
    notifyListeners();
  }

  /// Marks the safety checklist validated and stations as ready.
  void submitChecklist() {
    _operation.checklistCompleted = true;
    _operation.jettyStatus = 'Ready';
    _operation.boosterStatus = 'Ready';
    _operation.tankStatus = 'Ready';
    notifyListeners();
  }

  /// Transition: Setup -> Initialized.
  void submitInitialReadings({required String flowMeterReading}) {
    _operation.initialFlowMeterReading = flowMeterReading;
    _operation.initialCheckCompletedAt = DateTime.now();
    _state = OperationState.initialized;
    _syncTimers();
    notifyListeners();
  }

  /// Transition: Initialized -> Active. Starts the discharge clock.
  void beginDischarge() {
    _operation.startedAt = DateTime.now();
    _operation.lastReadingAt = _operation.startedAt;
    _state = OperationState.active;
    _syncTimers();
    notifyListeners();
  }

  /// Monitoring loop: appends an hourly reading, stays Active.
  void recordHourlyReading(HourlyReadingData reading) {
    _operation.hourlyReadings.add(reading);
    _operation.lastReadingAt = DateTime.now();
    _state = OperationState.active;
    _syncTimers();
    notifyListeners();
  }

  /// Transition: Active -> Halted.
  void halt() {
    _state = OperationState.halted;
    _syncTimers();
    notifyListeners();
  }

  /// Transition: Halted -> Active.
  void resume() {
    _state = OperationState.active;
    _syncTimers();
    notifyListeners();
  }

  /// Stores the closing flow meter reading without completing the operation,
  /// so a summary recap can be shown first.
  void stageFinalReadings(String finalFlowMeterReading) {
    _operation.finalFlowMeterReading = finalFlowMeterReading;
    notifyListeners();
  }

  /// Transition: Active -> Idle. Archives the finished operation and resets
  /// the current one so Home returns to State A.
  void completeOperation({String? finalFlowMeterReading}) {
    if (finalFlowMeterReading != null) {
      _operation.finalFlowMeterReading = finalFlowMeterReading;
    }
    _operation.completedAt = DateTime.now();
    _completedOperations.add(_operation);
    _operation = Operation();
    _state = OperationState.idle;
    _syncTimers();
    notifyListeners();
  }

  /// Clears the raised hourly prompt after it has been acted on.
  void clearHourlyPrompt() {
    _hourlyPromptDue = false;
    _syncTimers();
    notifyListeners();
  }

  void _syncTimers() {
    final bool active = _state == OperationState.active;

    if (active && _ticker == null) {
      _ticker = Timer.periodic(
        const Duration(seconds: 1),
        (_) => notifyListeners(),
      );
    } else if (!active && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
    }

    if (active && !_hourlyPromptDue && _promptTimer == null) {
      _promptTimer = Timer(hourlyPromptInterval, () {
        _promptTimer = null;
        _hourlyPromptDue = true;
        notifyListeners();
      });
    } else if ((!active || _hourlyPromptDue) && _promptTimer != null) {
      _promptTimer?.cancel();
      _promptTimer = null;
    }

    if (!active) _hourlyPromptDue = false;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _promptTimer?.cancel();
    super.dispose();
  }
}
