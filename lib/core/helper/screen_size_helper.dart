import 'package:flutter/material.dart';

class ScreenSizeHelper {
  final BuildContext context;
  ScreenSizeHelper(this.context);
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get horizontalPadding => screenWidth * 0.05;
  double get authVerticalPadding => screenHeight * 0.2;
  double get homeVerticalPadding => screenHeight * 0.02;
}
