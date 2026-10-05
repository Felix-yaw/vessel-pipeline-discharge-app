import 'package:flutter/foundation.dart';
import 'package:vessel_pipeline_discharge_app/core/utils/time_utils.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';

/// Central state machine for the discharge operation lifecycle.
///
/// Screens mutate the state through the public transition methods and the
/// home screen listens for changes to render State A (idle) or State B
/// (active). Kept as a lightweight [ChangeNotifier] singleton so no external
/// state-management package is required.
class OperationController extends ChangeNotifier {
  /// Creates a fresh controller with the state machine at Idle.
  OperationController();

  /// How long an operation is expected to take, used for EST. completion.
  static const Duration estimatedDischargeDuration = Duration(hours: 8);

  /// Interval the home screen waits before auto-prompting an hourly reading.
  ///
  /// Shortened to 30 seconds for demos; set to `Duration(hours: 1)` in
  /// production to match a real hourly cadence.
  static const Duration hourlyPromptInterval = Duration(seconds: 30);

  OperationState _state = OperationState.idle;
  Operation _operation = Operation();
  final List<Operation> _completedOperations = [];

  Station _selectedStation = Station.jetty;
  bool _roleChosen = false;
  final Set<Station> _readyStations = {Station.jetty};
  final Set<Station> _stationsWithReadings = {};

  OperationState get state => _state;
  Operation get operation => _operation;
  List<Operation> get completedOperations =>
      List.unmodifiable(_completedOperations);

  /// The station whose perspective is currently being shown on Home.
  Station get selectedStation => _selectedStation;

  /// Whether the operator has picked their station for this session.
  bool get roleChosen => _roleChosen;

  /// Switches the Home card between the Jetty / Booster / Tank perspective.
  void selectStation(Station station) {
    _roleChosen = true;
    if (_selectedStation == station) {
      notifyListeners();
      return;
    }
    _selectedStation = station;
    notifyListeners();
  }

  /// Whether [station] has confirmed its readiness for the current operation.
  bool isStationReady(Station station) => _readyStations.contains(station);

  /// Whether every station has confirmed its readiness.
  bool get allStationsReady =>
      Station.values.every(_readyStations.contains);

  /// Marks [station] ready once its operator completes the readiness check.
  void confirmReadiness(Station station) {
    if (_readyStations.contains(station)) return;
    _readyStations.add(station);
    notifyListeners();
  }

  /// Marks every station ready at once (all readiness checks completed).
  void confirmAllStationsReady() {
    if (allStationsReady) return;
    _readyStations.addAll(Station.values);
    notifyListeners();
  }

  /// Whether [station] has submitted its opening (initial) readings.
  bool hasStationReadings(Station station) =>
      _stationsWithReadings.contains(station);

  /// Records that [station] submitted its opening readings.
  void submitStationReadings(Station station) {
    if (_stationsWithReadings.contains(station)) return;
    _stationsWithReadings.add(station);
    notifyListeners();
  }

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
    _operation = Operation(
      vesselName: vesselName,
      vesselType: vesselType,
    );
    _readyStations
      ..clear()
      ..add(Station.jetty);
    _stationsWithReadings.clear();
    _state = OperationState.setup;
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
    notifyListeners();
  }

  /// Transition: Initialized -> Active. Starts the discharge clock.
  void beginDischarge() {
    _operation.startedAt = DateTime.now();
    _operation.lastReadingAt = _operation.startedAt;
    _state = OperationState.active;
    notifyListeners();
  }

  /// Monitoring loop: appends an hourly reading, stays Active.
  void recordHourlyReading(HourlyReadingData reading) {
    _operation.hourlyReadings.add(reading);
    _operation.lastReadingAt = DateTime.now();
    _state = OperationState.active;
    notifyListeners();
  }

  /// Transition: Active -> Halted.
  void halt() {
    _state = OperationState.halted;
    notifyListeners();
  }

  /// Transition: Halted -> Active.
  void resume() {
    _state = OperationState.active;
    notifyListeners();
  }

  /// Stores the closing flow meter reading without completing the operation,
  /// so a summary recap can be shown first.
  void stageFinalReadings(String finalFlowMeterReading) {
    _operation.finalFlowMeterReading = finalFlowMeterReading;
    notifyListeners();
  }

  /// Transition: Active -> Idle. Archives the finished operation and resets
  /// the current one so Home returns to State A. Uses the reading staged by
  /// [stageFinalReadings] unless one is passed explicitly.
  void completeOperation({String? finalFlowMeterReading}) {
    if (finalFlowMeterReading != null) {
      _operation.finalFlowMeterReading = finalFlowMeterReading;
    }
    _operation.completedAt = DateTime.now();
    _completedOperations.add(_operation);
    _operation = Operation();
    _readyStations
      ..clear()
      ..add(Station.jetty);
    _stationsWithReadings.clear();
    _state = OperationState.idle;
    notifyListeners();
  }
}
