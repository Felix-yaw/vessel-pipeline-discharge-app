import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_statistic.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_status_row.dart';

class OperationCardInfo extends StatelessWidget {
  final String status;

  const OperationCardInfo({super.key, this.status = 'Active'});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getProportionateScreenWidth(8),
          right: getProportionateScreenWidth(8),
          top: getProportionateHeight(8),
          child: OperationStatusRow(label: 'CURRENT OPERATION', status: status),
        ),
        Positioned(
          left: getProportionateScreenWidth(16),
          right: getProportionateScreenWidth(16),
          top: getProportionateHeight(96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vessel',
                    style: TextStyle(
                      fontSize: getProportionateHeight(12),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'VES 101203',
                    style: TextStyle(
                      fontSize: getProportionateHeight(12),
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateHeight(4)),
              Text(
                'MT African Spirit',
                style: TextStyle(
                  fontSize: getProportionateHeight(20),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(16),
          right: getProportionateScreenWidth(16),
          top: getProportionateHeight(162),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OperationStatistic(title: 'Started', value: '12:00 PM'),
              OperationStatistic(title: 'Elapsed', value: '00:00:00'),
              OperationStatistic(title: 'EST. Completion', value: '8:00 PM'),
            ],
          ),
        ),
      ],
    );
  }
}
