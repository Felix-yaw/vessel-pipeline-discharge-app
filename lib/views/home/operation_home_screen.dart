import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/navigation_provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
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

/// Root home. Tab shell with Home / History / Alerts via the bottom nav.
///
/// Stateless; the operation card is swapped by a [Consumer] on the simple
/// [OperationProvider], so only that card repaints each second.
class OperationHomeScreen extends StatelessWidget {
  const OperationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = context.watch<NavigationProvider>().currentIndex;

    void onNavTap(int index) =>
        context.read<NavigationProvider>().setIndex(index);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: selectedIndex == 0
                ? const _HomeContent()
                : selectedIndex == 1
                    ? const HistoryScreen()
                    : const AlertsScreen(),
          ),
          CustomBottomNavBar(selectedIndex: selectedIndex, onTap: onNavTap),
        ],
      ),
    );
  }
}

/// Home tab content. The hero card plus the active-operations section.
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  void _startOperation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const JettyChecklistScreen()),
    );
  }

  void _halt(BuildContext context) {
    context.read<OperationProvider>().halt();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HaltScreen()),
    );
  }

  void _finalReadings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FinalReadingsScreen()),
    );
  }

  void _recordReadings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HourlyReadingPromptScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilds this section only when active-ness or halt flips (not each
    // second); the operation card ticks on its own via a Consumer.
    final bool hasActive =
        context.select<OperationProvider, bool>((provider) => provider.hasActiveOperation);
    final bool halted =
        context.select<OperationProvider, bool>((provider) => provider.state == OperationState.halted);

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
                  child: _heroCard(context),
                ),
                if (hasActive)
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateHeight(32),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20),
                    ),
                    child: Consumer<OperationProvider>(
                      builder: (context, provider, _) => StationStatusGrid(
                        jettyStatus: provider.operation.jettyStatus,
                        boosterStatus: provider.operation.boosterStatus,
                        tankStatus: provider.operation.tankStatus,
                      ),
                    ),
                  ),
                if (hasActive && !halted)
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateHeight(24),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20),
                      bottom: getProportionateHeight(24),
                    ),
                    child: Column(
                      children: [
                        GradientButton(
                          label: 'Halt Discharge',
                          height: getProportionateHeight(56),
                          backgroundColor: AppColors.haltBackground,
                          textColor: AppColors.haltText,
                          onPressed: () => _halt(context),
                        ),
                        SizedBox(height: getProportionateHeight(12)),
                        GradientButton(
                          label: 'Final Readings',
                          height: getProportionateHeight(56),
                          backgroundColor: AppColors.tabColor,
                          textColor: AppColors.primaryColor,
                          onPressed: () => _finalReadings(context),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const _HourlyPromptListener(),
      ],
    );
  }

  Widget _heroCard(BuildContext context) {
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
            child: Consumer<OperationProvider>(
              builder: (context, provider, _) => provider.hasActiveOperation
                  ? ActiveOperationCard(
                      vesselName: provider.operation.vesselName,
                      code: provider.operation.vesselCode,
                      started: provider.startedText,
                      elapsed: provider.elapsedText,
                      estCompletion: provider.estCompletionText,
                      isHalted: provider.state == OperationState.halted,
                      onRecordReadings: () => _recordReadings(context),
                      onResume: () => context.read<OperationProvider>().resume(),
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
                            onPressed: () => _startOperation(context),
                          ),
                        ),
                      ],
                    ),
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
                'James Dinks',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: getProportionateHeight(23),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Consumer<OperationProvider>(
            builder: (context, provider, _) => provider.hasActiveOperation
                ? Positioned(
                    right: getProportionateScreenWidth(16),
                    top: getProportionateHeight(32),
                    child: _activeBadge(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _activeBadge() {
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
}

/// Watches the provider's hourly-prompt flag and navigates to the prompt
/// screen when it raises. Stateless; the timer lives in [OperationProvider].
class _HourlyPromptListener extends StatelessWidget {
  const _HourlyPromptListener();

  @override
  Widget build(BuildContext context) {
    final bool due =
        context.select<OperationProvider, bool>((provider) => provider.hourlyPromptDue);
    if (due) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        context.read<OperationProvider>().clearHourlyPrompt();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HourlyReadingPromptScreen()),
        );
      });
    }
    return const SizedBox.shrink();
  }
}
