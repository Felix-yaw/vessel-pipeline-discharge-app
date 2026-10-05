import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/hourly_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/initial_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_card_info.dart';

/// The operation card shown from the Booster / Tank perspective.
///
/// These stations confirm readiness and record their opening readings. Once
/// the discharge is underway they can only **Halt Discharge** (to flag a
/// problem) then record an hourly reading; they cannot resume or end the
/// operation. After a halt they wait for the operation to be confirmed again
/// before the halt control returns.
class StationFlowCard extends StatefulWidget {
  final Station station;

  const StationFlowCard({super.key, required this.station});

  @override
  State<StationFlowCard> createState() => _StationFlowCardState();
}

class _StationFlowCardState extends State<StationFlowCard> {
  /// How long the "Awaiting Discharge" state lasts before the operation is
  /// considered underway again. A backend confirmation will drive this later.
  static const Duration awaitingDuration = Duration(seconds: 3);

  bool _discharging = false;
  Timer? _awaitTimer;

  @override
  void dispose() {
    _awaitTimer?.cancel();
    super.dispose();
  }

  void _scheduleDischarge() {
    if (_discharging || _awaitTimer != null) return;
    _awaitTimer = Timer(awaitingDuration, () {
      _awaitTimer = null;
      if (!mounted) return;
      final OperationController controller =
          context.read<OperationController>();
      if (controller.state != OperationState.active &&
          controller.state != OperationState.halted) {
        controller.beginDischarge();
      }
      setState(() => _discharging = true);
    });
  }

  void _cancelAwait() {
    _awaitTimer?.cancel();
    _awaitTimer = null;
  }

  Future<void> _halt() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => const HourlyReadingsScreen()),
    );
    if (!mounted) return;
    setState(() => _discharging = false);
  }

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final bool isReady = controller.isStationReady(widget.station);
    final bool hasReadings = controller.hasStationReadings(widget.station);

    if (!isReady || !hasReadings) {
      _cancelAwait();
    } else if (!_discharging) {
      _scheduleDischarge();
    }

    final String status;
    if (!isReady) {
      status = 'Pending';
    } else if (_discharging) {
      status = 'Discharging';
    } else {
      status = 'Ready';
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          OperationCardInfo(status: status),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(230),
            child: _buildAction(context, controller, isReady, hasReadings),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    OperationController controller,
    bool isReady,
    bool hasReadings,
  ) {
    if (!isReady) {
      return GradientButton(
        label: 'Confirm Readiness',
        onPressed: () => controller.confirmReadiness(widget.station),
      );
    }

    if (!hasReadings) {
      return GradientButton(
        label: 'Record Initial Readings',
        showCheckIcon: true,
        onPressed: () async {
          final result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => const InitialReadingsScreen()),
          );
          if (result == true) {
            controller.submitStationReadings(widget.station);
          }
        },
      );
    }

    if (_discharging) {
      return GradientButton(
        label: 'Halt Discharge',
        backgroundColor: AppColors.haltBackground,
        textColor: AppColors.haltText,
        onPressed: _halt,
      );
    }

    return const GradientButton(
      label: 'Awaiting Discharge',
      backgroundColor: AppColors.primaryTranslucent,
      textColor: AppColors.white,
      onPressed: null,
    );
  }
}