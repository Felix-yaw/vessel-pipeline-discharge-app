import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/custom_dropdown_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/gradient_button.dart';

/// Screen shown when recording initial readings.
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
            Container(
              width: getProportionateScreenWidth(336),
              height: getProportionateHeight(134),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getProportionateHeight(32)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset(
                    'assets/images/background2.svg',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: getProportionateScreenWidth(16),
                    top: getProportionateHeight(16),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primaryColor,
                            size: getProportionateHeight(20),
                          ),
                          SizedBox(width: getProportionateScreenWidth(8)),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: getProportionateHeight(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: getProportionateScreenWidth(16),
                    right: getProportionateScreenWidth(16),
                    top: getProportionateHeight(62),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Initial Readings',
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: getProportionateHeight(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: getProportionateHeight(4)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MT African Spirit',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: getProportionateHeight(23),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'VES 101203',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: getProportionateHeight(14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Record opening readings before discharge begins',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(38)),
                    const CustomDropdownField(
                      title: 'Expected tank',
                      hintText: 'Select tank',
                      items: ['Tank 1', 'Tank 2', 'Tank 3'],
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    Text(
                      'Flow Meter Readings',
                      style: TextStyle(
                        fontSize: getProportionateHeight(18),
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(14)),
                    const CustomTextField(
                      title: 'Mass',
                      hintText: 'MT African Spirit',
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Density',
                      hintText: '0.00',
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Temperature',
                      hintText: '0.00',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: getProportionateScreenWidth(376),
              height: getProportionateHeight(76),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(getProportionateHeight(24)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withValues(alpha: 0.06),
                    blurRadius: getProportionateHeight(8),
                    offset: Offset(0, getProportionateHeight(-2)),
                  ),
                ],
              ),
              child: Center(
                child: GradientButton(
                  label: 'Submit',
                  width: getProportionateScreenWidth(336),
                  height: getProportionateHeight(56),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}