import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Fixed-height bottom bar that hosts the primary action button.
///
/// Replicates the floating shadow container used at the bottom of the
/// reading screens so the pattern lives in one place.
class BottomActionBar extends StatelessWidget {
  final Widget child;

  const BottomActionBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(376),
      height: getProportionateHeight(76),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.06),
            blurRadius: getProportionateHeight(8),
            offset: Offset(0, getProportionateHeight(-2)),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
