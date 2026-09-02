import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/operation_scaffold.dart';

/// Screen showing summary of all completed readings.
class ChecklistSummaryScreen extends StatelessWidget {
  final List<HourlyReadingData> hourlyReadings;
  final String vesselName;

  const ChecklistSummaryScreen({
    super.key,
    required this.hourlyReadings,
    this.vesselName = 'MT African Spirit',
  });

  @override
  Widget build(BuildContext context) {
    return OperationScaffold(
      title: 'Summary',
      name: vesselName,
      code: 'VES 101203',
      safeArea: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateHeight(24),
      ),
      bottomBar: true,
      bottom: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateHeight(16),
        ),
        child: SizedBox(
          width: double.infinity,
          height: getProportionateHeight(56),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B52A7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: getProportionateHeight(18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...hourlyReadings.map(
            (reading) => Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(16)),
              child: _buildHourCard(context, reading),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourCard(
    BuildContext context,
    HourlyReadingData reading,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(12)),
      ),
      padding: EdgeInsets.all(getProportionateHeight(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hour ${reading.hour}',
            style: TextStyle(
              fontSize: getProportionateHeight(18),
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: getProportionateHeight(12)),
          _buildReadingRow('Flow rate', reading.flowRate),
          SizedBox(height: getProportionateHeight(8)),
          _buildReadingRow('Total discharge', reading.totalDischarge),
          SizedBox(height: getProportionateHeight(8)),
          _buildReadingRow(
            'Remaining on board',
            reading.remainingOnBoard,
          ),
        ],
      ),
    );
  }

  Widget _buildReadingRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: getProportionateHeight(14),
            color: AppColors.greyColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: getProportionateHeight(14),
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}