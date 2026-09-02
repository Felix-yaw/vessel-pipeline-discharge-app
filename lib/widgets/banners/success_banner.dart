import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Success banner shown at the top of the initial readings page.
class SuccessBanner extends StatelessWidget {
  final VoidCallback? onStart;

  const SuccessBanner({super.key, this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(324),
      height: getProportionateHeight(115),
      padding: EdgeInsets.all(getProportionateHeight(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.06),
            blurRadius: getProportionateHeight(8),
            offset: Offset(0, getProportionateHeight(-2)),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: [
                Container(
                  width: getProportionateHeight(24),
                  height: getProportionateHeight(24),
                  decoration: const BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(8)),
                Text(
                  'All Stations Ready!',
                  style: TextStyle(
                    color: AppColors.successGreen,
                    fontSize: getProportionateHeight(16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: getProportionateHeight(36),
            left: 0,
            child: Text(
              'Start Recording initial readings',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: getProportionateHeight(12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onStart,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateHeight(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(getProportionateHeight(8)),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: getProportionateHeight(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}