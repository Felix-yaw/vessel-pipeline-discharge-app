import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/custom_bottom_nav_bar.dart';
import 'package:vessel_pipeline_discharge_app/widgets/grid_painter.dart';
import 'package:vessel_pipeline_discharge_app/widgets/operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _stationStatus = 'Inactive';

  void _handleStartDischarge() {
    setState(() => _stationStatus = 'Ready');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateHeight(54),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getProportionateHeight(32)),
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
              child: StationStatus(status: _stationStatus),
            ),
            SizedBox(height: getProportionateHeight(32.67)),
            const CustomBottomNavBar(
              selectedIndex: 0,
              onTap: _noopNavTap,
            ),
          ],
        ),
    );
  }

  static void _noopNavTap(int _) {}
}