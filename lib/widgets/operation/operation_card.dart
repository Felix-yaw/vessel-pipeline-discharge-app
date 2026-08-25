import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/checklist_summary_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/hourly_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/initial_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/new_operation_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/empty_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_card_info.dart';

/// The white card that sits over the background SVG with operation info.
class OperationCard extends StatefulWidget {
  final bool hasOperation;
  final VoidCallback? onContinue;
  final VoidCallback? onStartDischarge;
  final VoidCallback? onRecordReadings;

  const OperationCard({
    super.key,
    this.hasOperation = false,
    this.onContinue,
    this.onStartDischarge,
    this.onRecordReadings,
  });

  @override
  State<OperationCard> createState() => _OperationCardState();
}

/// Step the operation wizard is currently on.
enum _OperationStep {
  startOperation,
  recordReadings,
  startDischarge,
  haltDischarge,
  markChecks,
}

class _OperationCardState extends State<OperationCard> {
  late bool _showOperation;
  _OperationStep _step = _OperationStep.startOperation;
  final List<HourlyReadingData> _hourlyReadings = [];

  @override
  void initState() {
    super.initState();
    _showOperation = widget.hasOperation;
  }

  void _handleRetry() {
    setState(() {
      _showOperation = true;
      _step = _OperationStep.startOperation;
    });
    _hourlyReadings.clear();
    widget.onContinue?.call();
  }

  Future<void> _handleStartOperation() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const NewOperationScreen()),
    );
    if (result == true && mounted) {
      setState(() => _step = _OperationStep.recordReadings);
      widget.onRecordReadings?.call();
    }
  }

  Future<void> _handleRecordReadings() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const InitialReadingsScreen()),
    );
    if (result == true && mounted) {
      setState(() => _step = _OperationStep.startDischarge);
      widget.onStartDischarge?.call();
    }
  }

  void _handleStartDischarge() {
    setState(() => _step = _OperationStep.haltDischarge);
  }

  Future<void> _handleHaltDischarge() async {
    final HourlyReadingData? reading =
        await Navigator.of(context).push<HourlyReadingData>(
      MaterialPageRoute(builder: (_) => const HourlyReadingsScreen()),
    );
    if (reading == null || !mounted) return;
    setState(() => _hourlyReadings.add(reading));
    final bool? confirmed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ChecklistSummaryScreen(
          hourlyReadings: List.unmodifiable(_hourlyReadings),
          vesselName: 'MT African Spirit',
        ),
      ),
    );
    if (confirmed == true && mounted) {
      setState(() => _step = _OperationStep.markChecks);
    }
  }

  void _handleMarkChecks() {
    setState(() {
      _showOperation = false;
      _step = _OperationStep.startOperation;
    });
    _hourlyReadings.clear();
    widget.onContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _step != _OperationStep.startOperation &&
        _step != _OperationStep.recordReadings;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_showOperation)
            OperationCardInfo(status: isActive ? 'Active' : 'Pending')
          else
            const EmptyOperationCard(),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(230),
            child: GradientButton(
              label: !_showOperation
                  ? 'Retry'
                  : switch (_step) {
                      _OperationStep.markChecks => 'Mark Checks Completed',
                      _OperationStep.haltDischarge => 'Halt Discharge',
                      _OperationStep.startDischarge => 'Start discharge',
                      _OperationStep.recordReadings => 'Record initial readings',
                      _OperationStep.startOperation => 'Start Operation',
                    },
              onPressed: !_showOperation
                  ? _handleRetry
                  : switch (_step) {
                      _OperationStep.markChecks => _handleMarkChecks,
                      _OperationStep.haltDischarge => _handleHaltDischarge,
                      _OperationStep.startDischarge => _handleStartDischarge,
                      _OperationStep.recordReadings => _handleRecordReadings,
                      _OperationStep.startOperation => _handleStartOperation,
                    },
              backgroundColor: _step == _OperationStep.haltDischarge
                  ? AppColors.haltBackground
                  : null,
              textColor: _step == _OperationStep.haltDischarge
                  ? AppColors.haltText
                  : null,
              showCheckIcon: _step == _OperationStep.markChecks ||
                  _step == _OperationStep.recordReadings,
              showArrowIcon: _step == _OperationStep.startDischarge,
            ),
          ),
        ],
      ),
    );
  }
}
