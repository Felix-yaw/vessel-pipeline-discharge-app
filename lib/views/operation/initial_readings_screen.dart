import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_dropdown_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/bottom_action_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Screen shown when recording the opening readings before discharge begins.
class InitialReadingsScreen extends StatelessWidget {
  const InitialReadingsScreen({super.key});

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
            const PageHeader(
              title: 'Initial Readings',
              name: 'MT African Spirit',
              code: 'VES 101203',
              titleColor: AppColors.black,
            ),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Record the opening readings before discharge begins.',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(38)),
                    const CustomDropdownField(
                      title: 'Expected Tank',
                      hintText: 'Select tank',
                      items: ['Tank 1', 'Tank 2', 'Tank 3'],
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    Text(
                      'Flow Meter Reading',
                      style: TextStyle(
                        fontSize: getProportionateHeight(18),
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(14)),
                    const CustomTextField(
                      title: 'Mass',
                      hintText: 'eg. MT African Spirit',
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Density',
                      hintText: 'eg. MT African Spirit',
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Temperature',
                      hintText: 'eg. MT African Spirit',
                    ),
                  ],
                ),
              ),
            ),
            BottomActionBar(
              child: GradientButton(
                label: 'Submit',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                showTrailingArrow: true,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}