import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/navigation_provider.dart';
import 'package:vessel_pipeline_discharge_app/screen/homescreen.dart';
import 'package:vessel_pipeline_discharge_app/screen/alerts.dart';
import 'package:vessel_pipeline_discharge_app/screen/history.dart';
import 'package:vessel_pipeline_discharge_app/screen/navigation_bar.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';

void main() {
  runApp(const MainApp());
}

//wrap the app in navigationProvider or what you need,
//to initialize the screen size..wrap the opening screen in a builder that has the  screensize initialization before returning the first screen or widget

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OperationProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            ScreenSize.init(context);
            return CustomNavigationBar();
          },
        ),
      ),
    );
  }
}
