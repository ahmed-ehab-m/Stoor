import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, child) {
          return SlideTransition(
              position: slidingAnimation,
              child: Text('Stoor',
                  style: TextStyle(
                    fontFamily: 'DancingScript-VariableFont_wght',
                    fontSize: 80,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center));
        });
  }
}
