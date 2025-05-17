import 'package:bookly_app/core/utils/assetsData.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AssetsData.circleAnimation,
        height: 200, // غيرها حسب المساحة اللي انت عايزها
        repeat: true,
        reverse: false,
        animate: true,
      ),
    );
  }
}
