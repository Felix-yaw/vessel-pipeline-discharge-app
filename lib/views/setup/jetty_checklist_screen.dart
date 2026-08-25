import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_controller.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/setup/checklist_validation_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Page 2 - Jetty Checklist Details.
///
/// Captures the vessel name and vessel type, then begins the setup state
/// and advances to the checklist validation screen.
class JettyChecklistScreen extends StatefulWidget {
  const JettyChecklistScreen({super.key});

  @override
  State<JettyChecklistScreen> createState() => _JettyChecklistScreenState();
}

class _JettyChecklistScreenState extends State<JettyChecklistScreen> {
  final TextEditingController _vesselName = TextEditingController();
  final TextEditingController _vesselType = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vesselName.addListener(_onTextChanged);
    _vesselType.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _vesselName.dispose();
    _vesselType.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  bool get _isValid =>
      _vesselName.text.trim().isNotEmpty && _vesselType.text.trim().isNotEmpty;

  Future<void> _handleContinue() async {
    if (!_isValid) return;
    context.read<OperationController>().beginSetup(
      vesselName: _vesselName.text.trim(),
      vesselType: _vesselType.text.trim(),
    );
    final bool? result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ChecklistValidationScreen()),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
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
            const PageHeader(title: 'Jetty Checklist'),
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
                    CustomTextField(
                      title: 'Vessel Name',
                      hintText: 'e.g. MT African Spirit',
                      controller: _vesselName,
                    ),
                    SizedBox(height: getProportionateHeight(24)),
                    CustomTextField(
                      title: 'Vessel Type',
                      hintText: 'e.g. Tanker',
                      controller: _vesselType,
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
                onPressed: _isValid ? _handleContinue : null,
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
