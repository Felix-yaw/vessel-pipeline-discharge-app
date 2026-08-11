import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station_status_card.dart';

/// Section title plus a horizontally scrollable list of station status cards.
class StationStatus extends StatelessWidget {
  final String status;

  const StationStatus({super.key, this.status = 'Inactive'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Station Status',
          style: TextStyle(
            fontSize: getProportionateHeight(18),
            color: AppColors.greyColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getProportionateHeight(12)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StationStatusCard(title: 'Jetty', status: status),
              SizedBox(width: getProportionateScreenWidth(12)),
              StationStatusCard(title: 'Booseter', status: status),
              SizedBox(width: getProportionateScreenWidth(12)),
              StationStatusCard(title: 'Tank', status: status),
            ],
          ),
        ),
      ],
    );
  }
}