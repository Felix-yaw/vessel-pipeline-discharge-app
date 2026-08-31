import 'package:flutter/widgets.dart' show BuildContext, MediaQuery, MediaQueryData, Orientation, Size;

/// Holds the real screen metrics so [getProportionateHeight] and
/// [getProportionateScreenWidth] can scale design units to the device.
///
/// The design is authored against a fixed 375 x 812 canvas. Call [initData]
/// once (ideally in `main`) before any widget builds.
class ScreenSize {
  ScreenSize._();

  /// Design reference dimensions.
  static const double designWidth = 375;
  static const double designHeight = 812;

  static MediaQueryData _mediaQueryData = const MediaQueryData(
    size: Size(designWidth, designHeight),
  );
  static Orientation orientation = Orientation.portrait;

  static void init(BuildContext context) => initData(MediaQuery.of(context));

  static void initData(MediaQueryData data) {
    if (data.size.width <= 0 || data.size.height <= 0) return;
    _mediaQueryData = data;
    orientation = data.orientation;
  }
}

/// Scales a design height to the current screen.
double getProportionateHeight(double inputHeight) {
  // Phones (shortest side < 600): portrait divides by design height, landscape
  // by 360. Larger devices (tablets) always divide by design height.
  if (ScreenSize._mediaQueryData.size.shortestSide < 600) {
    if (ScreenSize.orientation == Orientation.portrait) {
      return (inputHeight / ScreenSize.designHeight) *
          ScreenSize._mediaQueryData.size.height;
    }
    return (inputHeight / 360.0) * ScreenSize._mediaQueryData.size.height;
  }
  return (inputHeight / ScreenSize.designHeight) *
      ScreenSize._mediaQueryData.size.height;
}

/// Scales a design width to the current screen.
double getProportionateScreenWidth(double inputWidth) {
  if (ScreenSize._mediaQueryData.size.shortestSide < 600) {
    if (ScreenSize.orientation == Orientation.portrait) {
      return (inputWidth / ScreenSize.designWidth) *
          ScreenSize._mediaQueryData.size.width;
    }
    return (inputWidth / 800.0) * ScreenSize._mediaQueryData.size.width;
  }
  return (inputWidth / ScreenSize.designWidth) *
      ScreenSize._mediaQueryData.size.width;
}
