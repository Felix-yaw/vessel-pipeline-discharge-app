import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_controller.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/home/operation_home_screen.dart';

/// Standalone entry point for the TRD flow.
///
/// The original `main.dart` is left untouched; run this one with:
///   flutter run -t lib/trd_main.dart
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initData(MediaQuery.of(context));
    return ChangeNotifierProvider<OperationController>(
      create: (_) => OperationController(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const OperationHomeScreen(),
      ),
    );
  }
}
