import 'package:flutter/material.dart';

/// Central color palette.
///
/// Every screen reads from here instead of hardcoding hex values, so a brand
/// color change is a one-line edit.
class AppColors {
  AppColors._();

  // Brand / primary
  static const Color primaryColor = Color(0xFF3B52A7);
  static const Color secondaryColor = Color(0xFF8895C4);

  // Surfaces
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);

  // Text
  static const Color textColor = Color(0xFF1C2B4A);
  static const Color greyColor = Color(0xFF8A94A6);

  // Status
  static const Color successGreen = Color(0xFF3DA35D);
  static const Color readyGreenBackground = Color(0xFFE1F3E6);

  // Controls / states
  static const Color tabColor = Color(0xFFEDF0F5);
  static const Color shadowColor = Color(0xFF3B52A7);

  // Buttons
  static const Color primaryTranslucent = Color(0x883B52A7);
  static const Color haltBackground = Color(0xFFFBE3E3);
  static const Color haltText = Color(0xFFC0392B);
}
