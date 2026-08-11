import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/confirm_operation_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/gradient_button.dart';
// import 'package:vessel_pipeline_discharge_app/widgets/grid_painter.dart';

/// Screen shown when starting a new operation.
class NewOperationScreen extends StatelessWidget {
  const NewOperationScreen({super.key});

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

                  /// const CustomPaint(
                  ///   painter: GridPainter(
                  ///     columns: 6,
                  ///     rows: 2.5,
                  ///     color: AppColors.secondaryColor,
                  ///   ),
                  /// ),
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
                    top: getProportionateHeight(62),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Operation',
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: getProportionateHeight(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: getProportionateHeight(4)),
                        Text(
                          'VES101203',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getProportionateHeight(23),
                            fontWeight: FontWeight.w500,
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
                      'Enter the information to begin the discharge operation',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(40)),
                    const CustomTextField(
                      title: 'Vessel name',
                      hintText: 'Enter vessel name',
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    const CustomTextField(
                      title: 'Product type',
                      hintText: 'Enter product type',
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    Row(
                      children: [
                        const Expanded(
                          child: CustomTextField(
                            title: 'Weight in Air',
                            hintText: '0.00',
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(16)),
                        const Expanded(
                          child: CustomTextField(
                            title: 'Weight in Vaccuum',
                            hintText: '0.00',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Continue',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                onPressed: () async {
                  final result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => const ConfirmOperationScreen(),
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
