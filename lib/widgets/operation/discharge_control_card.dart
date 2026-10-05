import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/hourly_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/discharge_completed_dialog.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_card_info.dart';

/// Shared discharge control card shown to every station once the operation is
/// running.
///
/// While [OperationState.active] it offers **Halt Discharge**; once halted it
/// offers **Resume** and **End**. Both the Jetty and the Booster / Tank use
/// this so a halt raised at any station is reflected everywhere.
class DischargeControlCard extends StatelessWidget {
  final VoidCallback? onEnded;

  const DischargeControlCard({super.key, this.onEnded});

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final bool isHalted = controller.state == OperationState.halted;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const OperationCardInfo(status: 'Discharging'),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(230),
            child: isHalted
                ? Row(
                    children: [
                      Expanded(
                        child: GradientButton(
                          label: 'Resume',
                          backgroundColor: AppColors.white,
                          textColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,
                          onPressed: controller.resume,
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(12)),
                      Expanded(
                        child: GradientButton(
                          label: 'End',
                          onPressed: () => _end(context, controller),
                        ),
                      ),
                    ],
                  )
                : GradientButton(
                    label: 'Halt Discharge',
                    backgroundColor: AppColors.haltBackground,
                    textColor: AppColors.haltText,
                    onPressed: () => _halt(context, controller),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _halt(
    BuildContext context,
    OperationController controller,
  ) async {
    controller.halt();
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => const HourlyReadingsScreen()),
    );
  }

  Future<void> _end(
    BuildContext context,
    OperationController controller,
  ) async {
    controller.completeOperation();
    onEnded?.call();
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => const DischargeCompletedDialog(),
    );
  }
}