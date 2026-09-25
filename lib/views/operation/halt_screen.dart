import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Page 7 - Halt/Resume Operation.
///
/// Large "Halt Discharge" status screen shown while the operation is paused.
/// "Resume" returns the state machine to Active and pops back to Home
/// State B.
class HaltScreen extends StatelessWidget {
  const HaltScreen({super.key});

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
            const PageHeader(title: 'Halt Discharge'),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getProportionateHeight(176),
                    height: getProportionateHeight(176),
                    decoration: BoxDecoration(
                      color: AppColors.haltBackground,
                      borderRadius: BorderRadius.circular(
                        getProportionateHeight(32),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pause_circle_rounded,
                          color: AppColors.haltText,
                          size: getProportionateHeight(48),
                        ),
                        SizedBox(height: getProportionateHeight(12)),
                        Text(
                          'Halt Discharge',
                          style: TextStyle(
                            color: AppColors.haltText,
                            fontSize: getProportionateHeight(20),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateHeight(28)),
                  Text(
                    'The discharge operation is paused.',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: getProportionateHeight(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Resume',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                backgroundColor: AppColors.successGreen,
                textColor: AppColors.white,
                onPressed: () {
                  context.read<OperationController>().resume();
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
