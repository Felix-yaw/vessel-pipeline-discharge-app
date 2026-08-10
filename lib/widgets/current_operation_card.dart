import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Shows the currently active operation: vessel info, timing and the primary
/// action button.
class CurrentOperationCard extends StatelessWidget {
  final VoidCallback onMarkComplete;

  const CurrentOperationCard({
    super.key,
    required this.onMarkComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateHeight(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(getProportionateHeight(20)),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'CURRENT OPERATION',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: getProportionateHeight(12),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateHeight(4),
                ),
                decoration: BoxDecoration(
                  color: AppColors.activeGreenBg,
                  borderRadius: BorderRadius.circular(
                    getProportionateHeight(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.activeGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(6)),
                    const Text(
                      'Active',
                      style: TextStyle(
                        color: AppColors.activeGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateHeight(16)),

          // Vessel section
          Row(
            children: [
              Text(
                'Vessel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: getProportionateHeight(12),
                ),
              ),
              const Spacer(),
              Text(
                'VES 101203',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: getProportionateHeight(12),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateHeight(4)),
          Text(
            'MT African Spirit',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(18),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: getProportionateHeight(16)),

          // Timing columns
          const Row(
            children: [
              _TimingColumn(label: 'Stated', value: '12:00 PM'),
              _TimingColumn(label: 'Elapsed', value: '00:00:00'),
              _TimingColumn(label: 'EST. Completion', value: '8:00 PM'),
            ],
          ),
          SizedBox(height: getProportionateHeight(18)),

          // Primary action
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
                onPressed: onMarkComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mark Checks Completed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.check_circle_outline, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimingColumn extends StatelessWidget {
  final String label;
  final String value;

  const _TimingColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: getProportionateHeight(10),
            ),
          ),
          SizedBox(height: getProportionateHeight(4)),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: getProportionateHeight(13),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
