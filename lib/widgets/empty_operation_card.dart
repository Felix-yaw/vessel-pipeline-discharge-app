import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Empty state shown when no operation is assigned.
class EmptyOperationCard extends StatelessWidget {
  const EmptyOperationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getProportionateScreenWidth(142),
          right: getProportionateScreenWidth(142),
          top: getProportionateHeight(48),
          child: SvgPicture.asset(
            'assets/icons/Frame 2025.svg',
            width: getProportionateScreenWidth(35),
            height: getProportionateHeight(32),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: getProportionateHeight(96),
          child: Text(
            'No Operation Assigned',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(23),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(55),
          right: getProportionateScreenWidth(55),
          top: getProportionateHeight(132),
          child: Text(
            "You don't have any operation assigned to you yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(14),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}