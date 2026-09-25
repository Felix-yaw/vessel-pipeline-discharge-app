import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/views/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OperationController(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            final MediaQueryData mediaQuery = MediaQuery.of(context);
            // On Android the view reports a 0x0 size for the first frame.
            // Building the app now would initialize ScreenSize with zeros, and
            // the const home widget would not rebuild once real metrics arrive.
            // Wait for a valid viewport, then initialize once.
            if (mediaQuery.size.isEmpty) {
              return const SizedBox.shrink();
            }
            ScreenSize().init(context);
            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
