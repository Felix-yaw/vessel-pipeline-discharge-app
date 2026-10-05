import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/confirm_operation_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/initial_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/new_operation_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/discharge_control_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/empty_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_card_info.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/station_role_dialog.dart';

/// The white card sitting over the background SVG with operation info.
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

enum _OperationStep {
  startOperation,
  recordReadings,
  startDischarge,
}

class _OperationCardState extends State<OperationCard> {
  late bool _showOperation;
  _OperationStep _step = _OperationStep.startOperation;

  @override
  void initState() {
    super.initState();
    _showOperation = widget.hasOperation;
  }

  Future<void> _handleRetry() async {
    final Station? station = await showDialog<Station>(
      context: context,
      builder: (_) => const StationRoleDialog(),
    );
    if (station == null || !mounted) return;
    context.read<OperationController>().selectStation(station);
    setState(() {
      _showOperation = true;
      _step = _OperationStep.startOperation;
    });
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
    if (result != true || !mounted) return;

    final confirmed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ConfirmOperationScreen()),
    );
    if (confirmed == true && mounted) {
      setState(() => _step = _OperationStep.startDischarge);
      widget.onStartDischarge?.call();
      context.read<OperationController>().confirmAllStationsReady();
    }
  }

  void _handleStartDischarge() {
    context.read<OperationController>().beginDischarge();
  }

  void _resetCard() {
    if (!mounted) return;
    setState(() {
      _showOperation = false;
      _step = _OperationStep.startOperation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final bool inDischarge = controller.state == OperationState.active ||
        controller.state == OperationState.halted;

    if (_showOperation && inDischarge) {
      return DischargeControlCard(onEnded: _resetCard);
    }

    final bool isPending =
        _showOperation && _step == _OperationStep.startOperation;

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
            OperationCardInfo(
              status: _step == _OperationStep.startOperation
                  ? 'Pending'
                  : 'Active',
              showOperationId: _step == _OperationStep.startOperation,
            )
          else
            const EmptyOperationCard(),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(isPending ? 162 : 230),
            child: GradientButton(
              label: !_showOperation
                  ? 'Retry'
                  : switch (_step) {
                      _OperationStep.startDischarge => 'Start discharge',
                      _OperationStep.recordReadings =>
                        'Record Initial Readings',
                      _OperationStep.startOperation => 'Start Operation',
                    },
              onPressed: !_showOperation
                  ? _handleRetry
                  : switch (_step) {
                      _OperationStep.startDischarge => _handleStartDischarge,
                      _OperationStep.recordReadings => _handleRecordReadings,
                      _OperationStep.startOperation => _handleStartOperation,
                    },
              showCheckIcon: _step == _OperationStep.recordReadings,
              showArrowIcon: _step == _OperationStep.startDischarge,
              showTrailingArrow: isPending,
            ),
          ),
        ],
      ),
    );
  }
}