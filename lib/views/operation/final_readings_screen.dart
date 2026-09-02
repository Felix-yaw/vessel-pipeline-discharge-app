import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/checklist_summary_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/operation_scaffold.dart';

/// Page 8 - Final Readings (closing form).
///
/// Captures the closing flow meter reading. Submitting completes the
/// operation, archives it, and resets the state machine to Idle so Home
/// returns to State A.
class FinalReadingsScreen extends StatefulWidget {
  const FinalReadingsScreen({super.key});

  @override
  State<FinalReadingsScreen> createState() => _FinalReadingsScreenState();
}

class _FinalReadingsScreenState extends State<FinalReadingsScreen> {
  final TextEditingController _flowMeterReading = TextEditingController();

  @override
  void initState() {
    super.initState();
    _flowMeterReading.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _flowMeterReading.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  bool get _isValid => _flowMeterReading.text.trim().isNotEmpty;

  Future<void> _handleSubmit() async {
    if (!_isValid) return;
    final OperationProvider controller = context.read<OperationProvider>();
    controller.stageFinalReadings(_flowMeterReading.text.trim());
    final bool? result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ChecklistSummaryScreen(
          hourlyReadings: controller.operation.hourlyReadings,
          vesselName: controller.operation.vesselName,
        ),
      ),
    );
    if (result == true && mounted) {
      controller.completeOperation();
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OperationProvider controller = context.read<OperationProvider>();
    return OperationScaffold(
      title: 'Final Readings',
      name: controller.operation.vesselName,
      code: controller.operation.vesselCode,
      bottom: GradientButton(
        label: 'Submit',
        width: getProportionateScreenWidth(336),
        height: getProportionateHeight(56),
        onPressed: _isValid ? _handleSubmit : null,
        backgroundColor: _isValid ? null : AppColors.primaryTranslucent,
        textColor: _isValid ? null : AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Record closing readings to complete the operation',
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(16),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: getProportionateHeight(38)),
          CustomTextField(
            title: 'Flow Meter Reading',
            hintText: '0.00',
            controller: _flowMeterReading,
          ),
        ],
      ),
    );
  }
}
