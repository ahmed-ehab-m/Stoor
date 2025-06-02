import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomLogoAnimation extends StatelessWidget {
  const CustomLogoAnimation(
      {super.key,
      required this.logoAnimationController,
      required this.logoSizeAnimation,
      required this.logoPositionAnimation});
  // Logo animations
  final AnimationController logoAnimationController;
  final Animation<double> logoSizeAnimation;
  final Animation<double> logoPositionAnimation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(logoPositionAnimation.value, 0),
        child: logoAnimationController.value == 1
            ? Icon(
                HugeIcons.strokeRoundedBookOpen02,
                color: Colors.white,
                size: logoSizeAnimation.value,
              )
            : ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [kPrimaryColor, Colors.white],
                    tileMode: TileMode.repeated,
                  ).createShader(bounds);
                },
                child: Icon(
                  HugeIcons.strokeRoundedBookOpen02,
                  color: Colors.white,
                  size: logoSizeAnimation.value,
                ),
              ),
      ),
    );
  }
}
