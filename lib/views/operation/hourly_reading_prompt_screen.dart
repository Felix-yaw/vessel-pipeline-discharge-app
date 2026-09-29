import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/hourly_reading_form_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';

/// Page 6a - Hourly Reading Prompt.
///
/// Full-screen notification shown when it is time to record hourly readings.
/// "Start Reading" opens the hourly reading form; completing it returns to
/// the active Home State B.
class HourlyReadingPromptScreen extends StatelessWidget {
  const HourlyReadingPromptScreen({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
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
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm_rounded,
                    color: AppColors.primaryColor,
                    size: getProportionateHeight(88),
                  ),
                  SizedBox(height: getProportionateHeight(28)),
                  Text(
                    "It's time for hourly readings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: getProportionateHeight(23),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: getProportionateHeight(8)),
                  Text(
                    'Record the latest flow meter readings to continue monitoring.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: getProportionateHeight(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Start Reading',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                onPressed: () async {
                  final bool? result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => const HourlyReadingFormScreen(),
                    ),
                  );
                  if (result == true && context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
