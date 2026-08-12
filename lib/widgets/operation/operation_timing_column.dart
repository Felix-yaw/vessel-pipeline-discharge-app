import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A single timing column with a label and a value.
class OperationTimingColumn extends StatelessWidget {
  final String label;
  final String value;

  const OperationTimingColumn({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(10),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: getProportionateHeight(4)),
          Text(
            value,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: getProportionateHeight(13),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}