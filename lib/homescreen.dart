import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/current_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/no_operation_card.dart';
import 'package:vessel_pipeline_discharge_app/widgets/station_status_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasOperation = false;
  bool _isRetrying = false;

  void _toggleState() {
    setState(() => _hasOperation = !_hasOperation);
  }

  Future<void> _handleRetry() async {
    setState(() => _isRetrying = true);
    // Simulate a fetch, then fall back to the "no operation" state.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _isRetrying = false;
      _hasOperation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Full background: gradient + grid
            const Positioned.fill(
              child: _Background(),
            ),

            // Content
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateHeight(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Greeting
                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: getProportionateHeight(14),
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(4)),
                    const Text(
                      'James Dinks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(28)),

                    // Conditional content
                    if (_hasOperation) ...[
                      CurrentOperationCard(
                        onMarkComplete: () {},
                      ),
                      SizedBox(height: getProportionateHeight(24)),
                      const StationStatusSection(
                        stations: ['Jetty', 'Booster', 'Tank'],
                      ),
                    ] else
                      NoOperationCard(
                        onRetry: _handleRetry,
                        isRetrying: _isRetrying,
                      ),
                  ],
                ),
              ),
            ),

            // Dev-only toggle to switch between the two states
            Positioned(
              top: getProportionateHeight(12),
              right: getProportionateScreenWidth(16),
              child: FloatingActionButton.small(
                heroTag: 'state-toggle',
                backgroundColor: Colors.white,
                onPressed: _toggleState,
                child: Icon(
                  _hasOperation
                      ? Icons.block_rounded
                      : Icons.play_arrow_rounded,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          fit: BoxFit.cover,
        ),
        const CustomPaint(
          painter: GridPainter(color: AppColors.secondaryColor),
        ),
      ],
    );
  }
}

/// Paints a grid of vertical and horizontal lines across the image.
class GridPainter extends CustomPainter {
  final Color color;

  const GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..strokeWidth = 1;

    const columns = 6;
    const rows = 7;

    for (var i = 0; i <= columns; i++) {
      final dx = size.width * i / columns;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    for (var i = 0; i <= rows; i++) {
      final dy = size.height * i / rows;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
