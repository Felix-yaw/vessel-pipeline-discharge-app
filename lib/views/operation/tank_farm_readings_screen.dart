import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/initial_check_confirmation_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/fields/custom_text_field.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/bottom_action_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/operation_scaffold.dart';

/// Page 4 - Tank Farm Initial Readings.
///
/// Captures the opening flow meter reading. Submitting advances the state
/// machine to Initialized and shows the initial check confirmation.
class TankFarmReadingsScreen extends StatefulWidget {
  const TankFarmReadingsScreen({super.key});

  @override
  State<TankFarmReadingsScreen> createState() => _TankFarmReadingsScreenState();
}

class _TankFarmReadingsScreenState extends State<TankFarmReadingsScreen> {
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
    context.read<OperationProvider>().submitInitialReadings(
      flowMeterReading: _flowMeterReading.text.trim(),
    );
    final bool? result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const InitialCheckConfirmationScreen()),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OperationProvider controller = context.read<OperationProvider>();
    return OperationScaffold(
      title: 'Tank Farm Initial Readings',
      name: controller.operation.vesselName,
      code: controller.operation.vesselCode,
      bottomBar: true,
      bottom: BottomActionBar(
        child: GradientButton(
          label: 'Submit',
          width: getProportionateScreenWidth(336),
          height: getProportionateHeight(56),
          onPressed: _isValid ? _handleSubmit : null,
          backgroundColor: _isValid ? null : AppColors.primaryTranslucent,
          textColor: _isValid ? null : AppColors.white,
        ),
      ),
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
