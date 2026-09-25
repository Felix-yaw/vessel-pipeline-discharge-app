import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/models/operation_models.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/views/alerts/alerts_screen.dart';
import 'package:vessel_pipeline_discharge_app/views/history/history_screen.dart';
import 'package:vessel_pipeline_discharge_app/widgets/banners/success_banner.dart';
import 'package:vessel_pipeline_discharge_app/widgets/navigation/custom_bottom_nav_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation/operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/painters/grid_painter.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station/station_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _handleNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _selectedIndex == 0
          ? const _HomeTabContent()
          : _selectedIndex == 1
          ? const HistoryScreen()
          : const AlertsScreen(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: getProportionateHeight(30.33)),
        child: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: _handleNavTap,
        ),
      ),
    );
  }
}

class _HomeTabContent extends StatefulWidget {
  const _HomeTabContent();

  @override
  State<_HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<_HomeTabContent> {
  bool _showBanner = false;
  Timer? _bannerTimer;

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }

  void _handleStartDischarge() {
    context.read<OperationController>().beginSetup(
      vesselName: 'Vessel',
      vesselType: 'General',
    );
  }

  void _handleRecordReadings() {
    setState(() => _showBanner = true);
    _bannerTimer?.cancel();
    _bannerTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showBanner = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.watch<OperationController>();
    final String stationStatus =
        controller.state == OperationState.active ||
            controller.state == OperationState.initialized ||
            controller.state == OperationState.setup
        ? 'Ready'
        : 'Inactive';

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateHeight(54),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateHeight(32),
                    ),
                  ),
                  height: getProportionateHeight(410),
                  width: getProportionateScreenWidth(336),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SvgPicture.asset(
                        'assets/images/background.svg',
                        fit: BoxFit.cover,
                      ),
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
                        child: OperationCard(
                          hasOperation: false,
                          onStartDischarge: _handleStartDischarge,
                          onRecordReadings: _handleRecordReadings,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateHeight(44),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                ),
                child: StationStatus(status: stationStatus),
              ),
            ],
          ),
        ),
        if (_showBanner)
          Positioned(
            left: 0,
            right: 0,
            top: getProportionateHeight(51),
            child: const Center(child: SuccessBanner()),
          ),
      ],
    );
  }
}
