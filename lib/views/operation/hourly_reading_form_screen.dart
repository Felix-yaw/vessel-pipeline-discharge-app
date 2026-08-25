import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_controller.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/core/utils/time_utils.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/bottom_action_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Page 6b - Hourly Reading Form.
///
/// Captures the flow meter and tank level readings for the current hour.
/// Submitting appends an [HourlyReadingData] to the active operation and
/// returns to Home State B.
class HourlyReadingFormScreen extends StatefulWidget {
  const HourlyReadingFormScreen({super.key});

  @override
  State<HourlyReadingFormScreen> createState() =>
      _HourlyReadingFormScreenState();
}

class _HourlyReadingFormScreenState extends State<HourlyReadingFormScreen> {
  final TextEditingController _flowRate = TextEditingController();
  final TextEditingController _tankLevelA = TextEditingController();
  final TextEditingController _tankLevelB = TextEditingController();

  @override
  void initState() {
    super.initState();
    _flowRate.addListener(_onTextChanged);
    _tankLevelA.addListener(_onTextChanged);
    _tankLevelB.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _flowRate.dispose();
    _tankLevelA.dispose();
    _tankLevelB.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  bool get _isValid =>
      _flowRate.text.trim().isNotEmpty &&
      _tankLevelA.text.trim().isNotEmpty &&
      _tankLevelB.text.trim().isNotEmpty;

  Future<void> _handleSubmit() async {
    if (!_isValid) return;
    final OperationController controller = context.read<OperationController>();
    final int hour = controller.operation.hourlyReadings.length + 1;
    controller.recordHourlyReading(
      HourlyReadingData(
        hour: hour,
        flowRate: _flowRate.text.trim(),
        tankLevelA: _tankLevelA.text.trim(),
        tankLevelB: _tankLevelB.text.trim(),
      ),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final int hour = controller.operation.hourlyReadings.length + 1;
    final DateTime now = DateTime.now();

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
            PageHeader(
              title: 'Hourly Readings',
              name: controller.operation.vesselName,
              code: controller.operation.vesselCode,
            ),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hour ${hour.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: getProportionateHeight(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          formatDateTime(now),
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: getProportionateHeight(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    CustomTextField(
                      title: 'Flow Meter Reading',
                      hintText: '0.00',
                      controller: _flowRate,
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    CustomTextField(
                      title: 'Tank Level A',
                      hintText: '0.00',
                      controller: _tankLevelA,
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    CustomTextField(
                      title: 'Tank Level B',
                      hintText: '0.00',
                      controller: _tankLevelB,
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
                onPressed: _isValid ? _handleSubmit : null,
                backgroundColor: _isValid ? null : AppColors.primaryTranslucent,
                textColor: _isValid ? null : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
