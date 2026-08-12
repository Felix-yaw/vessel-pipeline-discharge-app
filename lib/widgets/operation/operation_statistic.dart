import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

class OperationStatistic extends StatelessWidget {
  final String title;
  final String value;

  const OperationStatistic({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateHeight(10),
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: getProportionateHeight(4)),
          Text(
            value,
            style: TextStyle(
              fontSize: getProportionateHeight(14),
              color: AppColors.greyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}