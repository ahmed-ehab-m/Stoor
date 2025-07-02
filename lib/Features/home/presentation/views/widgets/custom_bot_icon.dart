import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBotIcon extends StatelessWidget {
  const CustomBotIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Colors.white,
            Color(0xffFFD400),
            // Blue
          ],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: const Icon(
        HugeIcons.strokeRoundedRobot01,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
