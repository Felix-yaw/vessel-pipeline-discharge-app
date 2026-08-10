import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Empty state shown when the user has no assigned operation.
class NoOperationCard extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isRetrying;

  const NoOperationCard({
    super.key,
    required this.onRetry,
    this.isRetrying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateHeight(24),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getProportionateScreenWidth(56),
            height: getProportionateScreenWidth(56),
            decoration: const BoxDecoration(
              color: AppColors.tabColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.primaryColor,
              size: 28,
            ),
          ),
          SizedBox(height: getProportionateHeight(16)),
          Text(
            'No Operation Assigned',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(20),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: getProportionateHeight(8)),
          Text(
            "You don't have any operation assigned to you yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: getProportionateHeight(13),
            ),
          ),
          SizedBox(height: getProportionateHeight(20)),
          SizedBox(
            width: double.infinity,
            height: getProportionateHeight(46),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.buttonGradientStart,
                    AppColors.buttonGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(getProportionateHeight(12)),
              ),
              child: ElevatedButton(
                onPressed: isRetrying ? null : onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: isRetrying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Retry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
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
