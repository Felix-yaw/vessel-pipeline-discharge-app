import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, MediaQueryData, Orientation;

// Must be called on initialization.
class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    defaultSize = screenHeight;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateHeight(double inputHeight) {
  final double screenHeight = ScreenSize.screenHeight;
  // 812 is the layout height the designer used

  // shortestSide helps determine the type of device
  // if less than 600, then it is a phone
  if (ScreenSize._mediaQueryData.size.shortestSide < 600) {
    if (ScreenSize.orientation == Orientation.portrait) {
      return (inputHeight / 812.0) * screenHeight;
    } else {
      return (inputHeight / 360.0) * screenHeight;
    }
  }

  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  final double screenWidth = ScreenSize.screenWidth;
  // 375 is the layout width the designer used

  // shortestSide helps determine the type of device
  // if less than 600, then it is a phone
  if (ScreenSize._mediaQueryData.size.shortestSide < 600) {
    if (ScreenSize.orientation == Orientation.portrait) {
      return (inputWidth / 375.0) * screenWidth;
    } else {
      return (inputWidth / 800.0) * screenWidth;
    }
  }

  return (inputWidth / 375.0) * screenWidth;
}
