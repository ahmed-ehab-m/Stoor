import 'package:flutter/material.dart';

class CustomTestAnimation extends StatelessWidget {
  const CustomTestAnimation(
      {super.key,
      required this.textAnimationController,
      required this.textOpacityAnimation,
      required this.logoPositionAnimation});
  // Text animations
  final AnimationController textAnimationController;
  final Animation<double> textOpacityAnimation;
  final Animation<double> logoPositionAnimation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(logoPositionAnimation.value + 100, 0), // على شمال اللوجو
        child: AnimatedBuilder(
          animation: textAnimationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: textOpacityAnimation,
              child: Text(
                ' Stoor',
                style: TextStyle(
                  color: Colors.white.withOpacity(textOpacityAnimation.value),
                  fontFamily: 'DancingScript-VariableFont_wght',
                  fontSize: 80,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
