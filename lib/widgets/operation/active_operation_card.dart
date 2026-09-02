import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_statistic.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_status_row.dart';

/// The active-operation card shown over the hero background on Home State B.
///
/// Shows the operation status pill, vessel identity, timing statistics and a
/// contextual action button (Record Readings while active, Resume while
/// halted).
class ActiveOperationCard extends StatelessWidget {
  final String vesselName;
  final String code;
  final String started;
  final String elapsed;
  final String estCompletion;
  final bool isHalted;
  final VoidCallback? onRecordReadings;
  final VoidCallback? onResume;

  const ActiveOperationCard({
    super.key,
    required this.vesselName,
    required this.code,
    required this.started,
    required this.elapsed,
    required this.estCompletion,
    this.isHalted = false,
    this.onRecordReadings,
    this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getProportionateScreenWidth(8),
          right: getProportionateScreenWidth(8),
          top: getProportionateHeight(8),
          child: OperationStatusRow(
            label: 'CURRENT OPERATION',
            status: isHalted ? 'Halted' : 'Active',
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(16),
          right: getProportionateScreenWidth(16),
          top: getProportionateHeight(96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vessel',
                    style: TextStyle(
                      fontSize: getProportionateHeight(12),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: getProportionateHeight(12),
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateHeight(4)),
              Text(
                vesselName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: getProportionateHeight(20),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(16),
          right: getProportionateScreenWidth(16),
          top: getProportionateHeight(162),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OperationStatistic(title: 'Started', value: started),
              OperationStatistic(title: 'Elapsed', value: elapsed),
              OperationStatistic(title: 'EST. Completion', value: estCompletion),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(8),
          right: getProportionateScreenWidth(8),
          top: getProportionateHeight(230),
          child: isHalted
              ? GradientButton(
                  label: 'Resume',
                  backgroundColor: AppColors.successGreen,
                  textColor: AppColors.white,
                  onPressed: onResume,
                )
              : GradientButton(
                  label: 'Record Readings',
                  showCheckIcon: true,
                  onPressed: onRecordReadings,
                ),
        ),
      ],
    );
  }
}
