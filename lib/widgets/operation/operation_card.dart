import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
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

class _OperationCardState extends State<OperationCard> {
  late bool _showOperation;
  bool _showRecordReadings = false;
  bool _showStartDischarge = false;
  bool _showHaltDischarge = false;
  bool _showMarkChecks = false;

  @override
  void initState() {
    super.initState();
    _showOperation = widget.hasOperation;
  }

  void _handleRetry() {
    setState(() => _showOperation = true);
    widget.onContinue?.call();
  }

  Future<void> _handleStartOperation() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const NewOperationScreen()),
    );
    if (result == true && mounted) {
      setState(() => _showRecordReadings = true);
      widget.onRecordReadings?.call();
    }
  }

  Future<void> _handleRecordReadings() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const InitialReadingsScreen()),
    );
    if (result == true && mounted) {
      setState(() => _showStartDischarge = true);
      widget.onStartDischarge?.call();
    }
  }

  void _handleStartDischarge() {
    setState(() => _showHaltDischarge = true);
  }

  Future<void> _handleHaltDischarge() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const HourlyReadingsScreen()),
    );
    if (result == true && mounted) {
      setState(() => _showMarkChecks = true);
    }
  }

  void _handleMarkChecks() {
    setState(() {
      _showOperation = false;
      _showRecordReadings = false;
      _showStartDischarge = false;
      _showHaltDischarge = false;
      _showMarkChecks = false;
    });
    widget.onContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool showOperation = _showOperation;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showOperation)
            OperationCardInfo(
              status: _showStartDischarge ? 'Active' : 'Pending',
            )
          else
            const EmptyOperationCard(),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(230),
            child: GradientButton(
              label: !showOperation
                  ? 'Retry'
                  : _showMarkChecks
                      ? 'Mark Checks Completed'
                      : _showHaltDischarge
                          ? 'Halt Discharge'
                          : _showStartDischarge
                              ? 'Start discharge'
                              : _showRecordReadings
                                  ? 'Record initial readings'
                                  : 'Start Operation',
              onPressed: !showOperation
                  ? _handleRetry
                  : _showMarkChecks
                      ? _handleMarkChecks
                      : _showHaltDischarge
                          ? _handleHaltDischarge
                          : _showStartDischarge
                              ? _handleStartDischarge
                              : _showRecordReadings
                                  ? _handleRecordReadings
                                  : _handleStartOperation,
              backgroundColor: !_showMarkChecks && _showHaltDischarge
                  ? AppColors.haltBackground
                  : null,
              textColor: !_showMarkChecks && _showHaltDischarge
                  ? AppColors.haltText
                  : null,
              showCheckIcon: _showMarkChecks ||
                  (_showRecordReadings && !_showStartDischarge),
              showArrowIcon: _showStartDischarge && !_showHaltDischarge,
            ),
          ),
        ],
      ),
    );
  }
}