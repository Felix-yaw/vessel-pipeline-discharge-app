import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';

/// Popup shown after tapping Retry so the operator picks the station they
/// belong to before the flow continues.
///
/// Returns the chosen [Station] via `Navigator.pop`.
class StationRoleDialog extends StatelessWidget {
  const StationRoleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
      ),
      child: Padding(
        padding: EdgeInsets.all(getProportionateHeight(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Your Station',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: getProportionateHeight(20),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: getProportionateHeight(8)),
            Text(
              'Choose the station you are operating from to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: getProportionateHeight(14),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: getProportionateHeight(20)),
            for (final Station station in Station.values) ...[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(station),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateHeight(14),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.tabColor,
                    borderRadius: BorderRadius.circular(
                      getProportionateHeight(14),
                    ),
                  ),
                  child: Text(
                    station.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: getProportionateHeight(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateHeight(12)),
            ],
          ],
        ),
      ),
    );
  }
}