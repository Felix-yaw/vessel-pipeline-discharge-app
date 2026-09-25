import 'package:flutter/material.dart';

import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';

class SafetyCheckScreen extends StatelessWidget {
  const SafetyCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateHeight(54),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Safety Check',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(38)),
                    const GradientButton(
                      label: 'Start Safety Check',
                      onPressed: null, // Replace with your onPressed logic
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
