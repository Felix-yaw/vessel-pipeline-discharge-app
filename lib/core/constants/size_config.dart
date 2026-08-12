import 'package:flutter/material.dart'
    show
        BuildContext,
        MediaQuery,
        MediaQueryData,
        Orientation,
        Size;

//Must be called on Initialization
class ScreenSize {
  // Design reference sizes used as safe defaults if metrics are not yet ready.
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static MediaQueryData _mediaQueryData = const MediaQueryData(
    size: Size(_designWidth, _designHeight),
  );
  static double screenWidth = _designWidth;
  static double screenHeight = _designHeight;
  static double defaultSize = _designHeight;
  static Orientation orientation = Orientation.portrait;

  void init(BuildContext context) {
    initData(MediaQuery.of(context));
  }

  static void initData(MediaQueryData mediaQueryData) {
    // Ignore zero/negative metrics reported before the first real layout.
    if (mediaQueryData.size.width <= 0 || mediaQueryData.size.height <= 0) {
      return;
    }
    _mediaQueryData = mediaQueryData;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateHeight(double inputHeight) {
  double screenHeight = ScreenSize.screenHeight;
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

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = ScreenSize.screenWidth;
  // 375 is the layout width that designer use

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
