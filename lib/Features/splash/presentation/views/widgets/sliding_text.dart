import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.pink, Colors.indigo],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(HugeIcons.strokeRoundedBookOpen02,
                      color: Colors.white, size: 100),
                ),
                Text('Stoor',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'DancingScript-VariableFont_wght',
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        });
  }
}
