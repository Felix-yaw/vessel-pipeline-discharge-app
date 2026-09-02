import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Placeholder content shown when the Alerts tab is selected.
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Alerts',
        style: TextStyle(
          fontSize: getProportionateHeight(24),
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}