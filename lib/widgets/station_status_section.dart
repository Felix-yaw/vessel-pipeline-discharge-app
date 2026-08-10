import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A row of station status pills (Jetty, Booster, Tank, ...).
class StationStatusSection extends StatelessWidget {
  final List<String> stations;

  const StationStatusSection({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Station Status',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: getProportionateHeight(16),
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: getProportionateHeight(12)),
        Wrap(
          spacing: getProportionateScreenWidth(10),
          runSpacing: getProportionateHeight(10),
          children: stations
              .map(
                (station) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(18),
                    vertical: getProportionateHeight(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      getProportionateHeight(20),
                    ),
                    border: Border.all(color: AppColors.greyTab),
                  ),
                  child: Text(
                    station,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: getProportionateHeight(13),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
