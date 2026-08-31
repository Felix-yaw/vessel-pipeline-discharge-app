import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/grid_painter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateHeight(54.0),
          left: getProportionateScreenWidth(20),
          right: (getProportionateScreenWidth(20)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getProportionateHeight(32)),
              child: Stack(
                children: [
                  // SVG Image Background
                  Container(
                    height: getProportionateHeight(410),
                    width: getProportionateScreenWidth(336),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateHeight(32),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/background(1).svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Grid Overlay using CustomPaint
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GridPainter(
                        rows: 7,
                        columns: 6,
                        gridColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
