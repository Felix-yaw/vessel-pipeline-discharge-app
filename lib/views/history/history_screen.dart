import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Placeholder content shown when the History tab is selected.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'History',
        style: TextStyle(
          fontSize: getProportionateHeight(24),
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}