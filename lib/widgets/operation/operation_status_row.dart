import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

class OperationStatusRow extends StatelessWidget {
  final String label;
  final String status;

  const OperationStatusRow({
    super.key,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive =
        status == 'Active' || status == 'Discharging' || status == 'Ready';
    final Color dotColor = isActive
        ? AppColors.successGreen
        : AppColors.primaryColor;
    final Color statusColor = isActive
        ? AppColors.successGreenText
        : AppColors.primaryColor;

    return Container(
      width: double.infinity,
      height: getProportionateHeight(42),
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(16),
        getProportionateHeight(8),
        getProportionateScreenWidth(8),
        getProportionateHeight(8),
      ),
      decoration: BoxDecoration(
        color: AppColors.tabColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: getProportionateHeight(14),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateHeight(4),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getProportionateHeight(31)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getProportionateHeight(8),
                  height: getProportionateHeight(8),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(8)),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: getProportionateHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}