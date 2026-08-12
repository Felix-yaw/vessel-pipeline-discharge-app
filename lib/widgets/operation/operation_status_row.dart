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
    final bool isActive = status == 'Active';
    final Color dotColor =
        isActive ? AppColors.successGreen : AppColors.primaryColor;
    final Color statusColor =
        isActive ? AppColors.successGreenText : AppColors.primaryColor;

    return Container(
      width: double.infinity,
      height: getProportionateHeight(42),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateHeight(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.tabColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: getProportionateHeight(14),
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
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
        ],
      ),
    );
  }
}