import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_controller.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/core/utils/time_utils.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Page 5 - Initial Check Confirmation (success state).
///
/// Confirms the initial readings were captured with a success icon, vessel
/// name and timestamp. "Next Discharge" starts the discharge clock and
/// returns Home to State B (Active).
class InitialCheckConfirmationScreen extends StatelessWidget {
  const InitialCheckConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final DateTime? timestamp = controller.operation.initialCheckCompletedAt;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateHeight(54),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            PageHeader(
              title: 'Initial Check Completed',
              name: controller.operation.vesselName,
              code: controller.operation.vesselCode,
            ),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getProportionateHeight(88),
                    height: getProportionateHeight(88),
                    decoration: const BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: getProportionateHeight(28)),
                  Text(
                    controller.operation.vesselName,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: getProportionateHeight(23),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: getProportionateHeight(8)),
                  Text(
                    timestamp == null ? '--' : formatClock(timestamp),
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: getProportionateHeight(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Next Discharge',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                onPressed: () {
                  context.read<OperationController>().beginDischarge();
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
