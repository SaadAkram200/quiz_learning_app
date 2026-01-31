import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  // Check if current screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  // Check if current screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  // Check if current screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  // Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Get content max width based on screen size
  static double getContentMaxWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 600;
    } else {
      return 800;
    }
  }

  // Get horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 16;
    } else if (isTablet(context)) {
      return 32;
    } else {
      return 48;
    }
  }

  // Get card width for grid layout
  static double getCardWidth(BuildContext context) {
    if (isMobile(context)) {
      return screenWidth(context) - 32;
    } else if (isTablet(context)) {
      return (screenWidth(context) - 96) / 2;
    } else {
      return 280;
    }
  }

  // Get number of grid columns based on screen size
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 1;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }
}

// Extension for responsive values
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveHelper.isMobile(this);
  bool get isTablet => ResponsiveHelper.isTablet(this);
  bool get isDesktop => ResponsiveHelper.isDesktop(this);
  double get screenWidth => ResponsiveHelper.screenWidth(this);
  double get screenHeight => ResponsiveHelper.screenHeight(this);
  double get contentMaxWidth => ResponsiveHelper.getContentMaxWidth(this);
  double get horizontalPadding => ResponsiveHelper.getHorizontalPadding(this);
}
