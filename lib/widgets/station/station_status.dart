import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station/station_status_card.dart';

/// Section title plus a horizontally scrollable list of station status cards.
class StationStatus extends StatelessWidget {
  final String jettyStatus;
  final String boosterStatus;
  final String tankStatus;

  const StationStatus({
    super.key,
    this.jettyStatus = 'Inactive',
    this.boosterStatus = 'Inactive',
    this.tankStatus = 'Inactive',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Station Status',
          style: TextStyle(
            fontSize: getProportionateHeight(20),
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: getProportionateHeight(12)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StationStatusCard(title: 'Jetty', status: jettyStatus),
              SizedBox(width: getProportionateScreenWidth(12)),
              StationStatusCard(title: 'Booster', status: boosterStatus),
              SizedBox(width: getProportionateScreenWidth(12)),
              StationStatusCard(title: 'Tank', status: tankStatus),
            ],
          ),
        ),
      ],
    );
  }
}