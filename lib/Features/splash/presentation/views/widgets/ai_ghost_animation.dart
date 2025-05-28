import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AiGhostAnimation extends StatelessWidget {
  const AiGhostAnimation(
      {super.key, required this.screenSizeHelper, required this.animation});
  final ScreenSizeHelper screenSizeHelper;
  final String animation;
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      animation,
      // width: screenSizeHelper.screenWidth * 8,
      height: screenSizeHelper.screenHeight * 0.5,
      fit: BoxFit.contain,
    );
  }
}
