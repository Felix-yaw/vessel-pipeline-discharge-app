import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Top notification shown to the Booster / Tank stations the moment the
/// discharge begins at the Jetty.
class DischargeStartedBanner extends StatelessWidget {
  const DischargeStartedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateHeight(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.08),
            blurRadius: getProportionateHeight(10),
            offset: Offset(0, getProportionateHeight(2)),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getProportionateHeight(24),
            height: getProportionateHeight(24),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.white,
              size: getProportionateHeight(14),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(
            'Discharge has begun at the Jetty',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}