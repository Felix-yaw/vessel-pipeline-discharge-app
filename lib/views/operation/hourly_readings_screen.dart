import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/bottom_action_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Screen shown when recording hourly readings.
///
/// Returns the entered readings as an [HourlyReadingData] via `Navigator.pop`
/// so the flow can continue once a reading is captured.
class HourlyReadingsScreen extends StatefulWidget {
  const HourlyReadingsScreen({super.key});

  @override
  State<HourlyReadingsScreen> createState() => _HourlyReadingsScreenState();
}

class _HourlyReadingsScreenState extends State<HourlyReadingsScreen> {
  final TextEditingController _flowRate = TextEditingController();
  final TextEditingController _totalDischarge = TextEditingController();
  final TextEditingController _remainingOnBoard = TextEditingController();

  @override
  void initState() {
    super.initState();
    _flowRate.addListener(_onTextChanged);
    _totalDischarge.addListener(_onTextChanged);
    _remainingOnBoard.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _flowRate.dispose();
    _totalDischarge.dispose();
    _remainingOnBoard.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  bool get _isValid =>
      _flowRate.text.trim().isNotEmpty &&
      _totalDischarge.text.trim().isNotEmpty &&
      _remainingOnBoard.text.trim().isNotEmpty;

  void _handleSubmit() {
    if (!_isValid) return;
    Navigator.of(context).pop(
      HourlyReadingData(
        hour: 1,
        flowRate: _flowRate.text.trim(),
        totalDischarge: _totalDischarge.text.trim(),
        remainingOnBoard: _remainingOnBoard.text.trim(),
      ),
    );
  }

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
              title: 'Hourly Readings',
              name: 'MT African Spirit',
              code: 'VES 101203',
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
                          'Hour 03',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: getProportionateHeight(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '30th July 2026, 13:00',
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
                      title: 'Flow rate',
                      hintText: '0.00',
                      controller: _flowRate,
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    CustomTextField(
                      title: 'Total discharge',
                      hintText: '0.00',
                      controller: _totalDischarge,
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    CustomTextField(
                      title: 'Remaining on board',
                      hintText: '0.00',
                      controller: _remainingOnBoard,
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    Text(
                      'Flow Meter Reading',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: getProportionateHeight(18),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Mass',
                      hintText: '0.00',
                    ),
                    SizedBox(height: getProportionateHeight(16)),
                    const CustomTextField(
                      title: 'Density',
                      hintText: '0.00',
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