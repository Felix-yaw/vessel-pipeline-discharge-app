import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';

/// Final screen for marking all checklist items completed.
class MarksChecksScreen extends StatefulWidget {
  const MarksChecksScreen({super.key});

  @override
  State<MarksChecksScreen> createState() => _MarksChecksScreenState();
}

class _MarksChecksScreenState extends State<MarksChecksScreen> {
  final List<bool> _checks = List.generate(6, (_) => false);

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: getProportionateHeight(14),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'MT African Spirit',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: getProportionateHeight(14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateHeight(4)),
                        Text(
                          'Monitoring Station',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: getProportionateHeight(20),
                            fontWeight: FontWeight.w600,
                          ),
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
                      'Complete all required checks before submitting',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    ..._buildChecks(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Submit Checklist',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChecks() {
    final titles = [
      'Verify all hourly readings are submitted',
      'Confirm final mass readings recorded',
      'Validate total discharge calculations',
      'Ensure all safety checks completed',
      'Confirm valve positions correct',
      'Confirm emergency procedures reviewed',
    ];
    return List.generate(titles.length, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateHeight(8),
        ),
        child: InkWell(
          onTap: () => setState(() => _checks[index] = !_checks[index]),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getProportionateHeight(12)),
            ),
            padding: EdgeInsets.all(getProportionateHeight(16)),
            child: Row(
              children: [
                Icon(
                  _checks[index]
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: _checks[index]
                      ? AppColors.successGreen
                      : AppColors.secondaryColor,
                  size: getProportionateHeight(24),
                ),
                SizedBox(width: getProportionateScreenWidth(12)),
                Expanded(
                  child: Text(
                    titles[index],
                    style: TextStyle(
                      fontSize: getProportionateHeight(16),
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}