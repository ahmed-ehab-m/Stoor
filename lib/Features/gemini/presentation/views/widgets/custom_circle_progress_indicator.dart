import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  const CustomCircleProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [
              Color(0xFFEC4899), // Pink
              Color(0xFFA855F7), // Purple
              Color(0xFF3B82F6), // Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
          ).createShader(bounds);
        },
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
    );
  }
}
