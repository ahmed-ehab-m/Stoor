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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          focalRadius: 0.8,
          colors: [
            Color(0xFFA855F7), // Purple
            Colors.transparent,
          ],
        ),
      ),
      child: LottieBuilder.asset(
        animation,
        height: screenSizeHelper.screenHeight * 0.5,
        fit: BoxFit.contain,
      ),
    );
  }
}
