import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestAnimation extends StatelessWidget {
  const TestAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeHelper.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Test Animation',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          LottieBuilder.asset(
            AssetsData.aiGhostAnimation,
            width: screenSizeHelper.screenWidth * 0.8,
            height: screenSizeHelper.screenHeight * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
