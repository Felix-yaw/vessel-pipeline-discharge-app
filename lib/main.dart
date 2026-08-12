import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/views/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Manrope',
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const _ScreenSizeScope(child: HomeScreen()),
    );
  }
}

/// Initializes [ScreenSize] with the real MediaQuery dimensions.
class _ScreenSizeScope extends StatefulWidget {
  final Widget child;

  const _ScreenSizeScope({required this.child});

  @override
  State<_ScreenSizeScope> createState() => _ScreenSizeScopeState();
}

class _ScreenSizeScopeState extends State<_ScreenSizeScope> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.initData(MediaQuery.of(context));
    return widget.child;
  }
}