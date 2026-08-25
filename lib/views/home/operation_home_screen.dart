import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_controller.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/views/alerts/alerts_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/history/history_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/final_readings_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/halt_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/operation/hourly_reading_prompt_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/setup/jetty_checklist_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/navigation/custom_bottom_nav_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/active_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/empty_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/painters/grid_painter.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station/station_status_grid.dart';

/// Root home for the TRD flow.
///
/// Tab shell with Home / History / Alerts using the existing bottom nav. The
/// Home tab renders State A ("No Operation Assigned") while idle and State B
/// (active operation) while the discharge is running, and drives the hourly
/// reading prompt timer during Active.
class OperationHomeScreen extends StatefulWidget {
  const OperationHomeScreen({super.key});

  @override
  State<OperationHomeScreen> createState() => _OperationHomeScreenState();
}

class _OperationHomeScreenState extends State<OperationHomeScreen> {
  int _selectedIndex = 0;

  void _handleNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _selectedIndex == 0
          ? _OperationTabContent(
              onNavTap: _handleNavTap,
              selectedIndex: _selectedIndex,
            )
          : Column(
              children: [
                Expanded(
                  child: _selectedIndex == 1
                      ? const HistoryScreen()
                      : const AlertsScreen(),
                ),
                CustomBottomNavBar(
                  selectedIndex: _selectedIndex,
                  onTap: _handleNavTap,
                ),
              ],
            ),
    );
  }
}

class _OperationTabContent extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const _OperationTabContent({
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  State<_OperationTabContent> createState() => _OperationTabContentState();
}

class _OperationTabContentState extends State<_OperationTabContent> {
  static const String _userName = 'James Dinks';

  Timer? _elapsedTimer;
  Timer? _promptTimer;
  bool _promptOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<OperationController>().addListener(_onControllerChanged);
    _syncTimers();
  }

  @override
  void dispose() {
    context.read<OperationController>().removeListener(_onControllerChanged);
    _elapsedTimer?.cancel();
    _promptTimer?.cancel();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(_syncTimers);
  }

  void _syncTimers() {
    final OperationController controller = context.read<OperationController>();
    final bool active = controller.state == OperationState.active;

    if (active && _elapsedTimer == null) {
      _elapsedTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {}),
      );
    } else if (!active && _elapsedTimer != null) {
      _elapsedTimer!.cancel();
      _elapsedTimer = null;
    }

    final bool wantPrompt = active && !_promptOpen;
    if (wantPrompt && _promptTimer == null) {
      _promptTimer = Timer(
        OperationController.hourlyPromptInterval,
        _onPromptDue,
      );
    } else if (!wantPrompt && _promptTimer != null) {
      _promptTimer!.cancel();
      _promptTimer = null;
    }
  }

  Future<void> _onPromptDue() async {
    _promptTimer = null;
    if (!mounted) return;
    final OperationController controller = context.read<OperationController>();
    if (controller.state != OperationState.active || _promptOpen) {
      _syncTimers();
      return;
    }
    _promptOpen = true;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const HourlyReadingPromptScreen()),
    );
    if (!mounted) return;
    _promptOpen = false;
    _syncTimers();
  }

  Future<void> _handleStartOperation() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const JettyChecklistScreen()),
    );
  }

  Future<void> _handleRecordReadings() async {
    if (_promptOpen) return;
    _promptOpen = true;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const HourlyReadingPromptScreen()),
    );
    if (!mounted) return;
    _promptOpen = false;
    _syncTimers();
  }

  Future<void> _handleHalt() async {
    context.read<OperationController>().halt();
    await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const HaltScreen()));
  }

  Future<void> _handleFinalReadings() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const FinalReadingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.read<OperationController>();
    final Operation operation = controller.operation;
    final bool showActive =
        controller.state == OperationState.active ||
        controller.state == OperationState.halted;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateHeight(54),
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(20),
                  ),
                  child: _buildHeroCard(controller, operation, showActive),
                ),
                if (showActive) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateHeight(32),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20),
                    ),
                    child: StationStatusGrid(
                      jettyStatus: operation.jettyStatus,
                      boosterStatus: operation.boosterStatus,
                      tankStatus: operation.tankStatus,
                    ),
                  ),
                  if (controller.state == OperationState.active) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: getProportionateHeight(24),
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(20),
                        bottom: getProportionateHeight(24),
                      ),
                      child: _buildControlButtons(),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
        CustomBottomNavBar(
          selectedIndex: widget.selectedIndex,
          onTap: widget.onNavTap,
        ),
      ],
    );
  }

  Widget _buildHeroCard(
    OperationController controller,
    Operation operation,
    bool showActive,
  ) {
    return Container(
      height: getProportionateHeight(410),
      width: getProportionateScreenWidth(336),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateHeight(32)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset('assets/images/background.svg', fit: BoxFit.cover),
          const CustomPaint(
            painter: GridPainter(
              columns: 6,
              rows: 7,
              color: AppColors.secondaryColor,
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateHeight(104),
            height: getProportionateHeight(298),
            child: showActive
                ? ActiveOperationCard(
                    vesselName: operation.vesselName,
                    code: operation.vesselCode,
                    started: controller.startedText,
                    elapsed: controller.elapsedText,
                    estCompletion: controller.estCompletionText,
                    isHalted: controller.state == OperationState.halted,
                    onRecordReadings: _handleRecordReadings,
                    onResume: () =>
                        context.read<OperationController>().resume(),
                  )
                : Stack(
                    children: [
                      const EmptyOperationCard(),
                      Positioned(
                        left: getProportionateScreenWidth(8),
                        right: getProportionateScreenWidth(8),
                        top: getProportionateHeight(230),
                        child: GradientButton(
                          label: 'Start Operation',
                          onPressed: _handleStartOperation,
                        ),
                      ),
                    ],
                  ),
          ),
          Positioned(
            left: getProportionateScreenWidth(106),
            top: getProportionateHeight(32),
            child: Center(
              child: Text(
                'Welcome Back',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: getProportionateHeight(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(90),
            top: getProportionateHeight(52),
            child: Center(
              child: Text(
                _userName,
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: getProportionateHeight(23),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (showActive)
            Positioned(
              right: getProportionateScreenWidth(16),
              top: getProportionateHeight(32),
              child: _buildActiveBadge(),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateHeight(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.successGreen,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getProportionateHeight(8),
            height: getProportionateHeight(8),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(6)),
          Text(
            'Active',
            style: TextStyle(
              color: AppColors.white,
              fontSize: getProportionateHeight(12),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Column(
      children: [
        GradientButton(
          label: 'Halt Discharge',
          height: getProportionateHeight(56),
          backgroundColor: AppColors.haltBackground,
          textColor: AppColors.haltText,
          onPressed: _handleHalt,
        ),
        SizedBox(height: getProportionateHeight(12)),
        GradientButton(
          label: 'Final Readings',
          height: getProportionateHeight(56),
          backgroundColor: AppColors.tabColor,
          textColor: AppColors.primaryColor,
          onPressed: _handleFinalReadings,
        ),
      ],
    );
  }
}
