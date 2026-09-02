import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/tank_farm_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/operation_scaffold.dart';

/// Page 3 - Checklist Validation.
///
/// Confirms the safety checklist is completed and toggles each station
/// (Jetty, Booster, Tank) to Ready. "Send Request" validates the checklist
/// and moves to the tank farm initial readings.
class ChecklistValidationScreen extends StatefulWidget {
  const ChecklistValidationScreen({super.key});

  @override
  State<ChecklistValidationScreen> createState() =>
      _ChecklistValidationScreenState();
}

class _ChecklistValidationScreenState extends State<ChecklistValidationScreen> {
  static const List<String> _equipment = ['Jetty', 'Booster', 'Tank'];

  final List<bool> _checks = List.generate(_equipment.length, (_) => false);

  bool get _allChecked => _checks.every((checked) => checked);

  Future<void> _handleSendRequest() async {
    if (!_allChecked) return;
    context.read<OperationProvider>().submitChecklist();
    final bool? result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const TankFarmReadingsScreen()),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OperationProvider controller = context.read<OperationProvider>();
    return OperationScaffold(
      title: 'Completed Checklist',
      name: controller.operation.vesselName,
      code: controller.operation.vesselCode,
      bottom: GradientButton(
        label: 'Send Request',
        width: getProportionateScreenWidth(336),
        height: getProportionateHeight(56),
        onPressed: _allChecked ? _handleSendRequest : null,
        backgroundColor: _allChecked ? null : AppColors.primaryTranslucent,
        textColor: _allChecked ? null : AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Is your safety checklist completed?',
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(16),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: getProportionateHeight(24)),
          ...List.generate(_equipment.length, _buildCheckTile),
        ],
      ),
    );
  }

  Widget _buildCheckTile(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateHeight(8)),
      child: InkWell(
        onTap: () => setState(() => _checks[index] = !_checks[index]),
        borderRadius: BorderRadius.circular(getProportionateHeight(12)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getProportionateHeight(12)),
          ),
          padding: EdgeInsets.all(getProportionateHeight(16)),
          child: Row(
            children: [
              Icon(
                _checks[index] ? Icons.check_circle : Icons.circle_outlined,
                color: _checks[index]
                    ? AppColors.successGreen
                    : AppColors.secondaryColor,
                size: getProportionateHeight(24),
              ),
              SizedBox(width: getProportionateScreenWidth(12)),
              Expanded(
                child: Text(
                  '${_equipment[index]} station ready',
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
  }
}
