import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';

/// Popup shown once a discharge operation has been ended.
class DischargeCompletedDialog extends StatelessWidget {
  const DischargeCompletedDialog({super.key});

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
          children: [
            Container(
              width: getProportionateHeight(72),
              height: getProportionateHeight(72),
              decoration: const BoxDecoration(
                color: AppColors.successGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: AppColors.white,
                size: getProportionateHeight(40),
              ),
            ),
            SizedBox(height: getProportionateHeight(20)),
            Text(
              'Discharge Completed',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: getProportionateHeight(20),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: getProportionateHeight(8)),
            Text(
              'The discharge operation has been ended successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: getProportionateHeight(14),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: getProportionateHeight(24)),
            GradientButton(
              label: 'Done',
              width: double.infinity,
              height: getProportionateHeight(48),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}