import 'package:flutter/material.dart';

class CustomShaderMask extends StatelessWidget {
  const CustomShaderMask({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              Color(0xFFEC4899), // Pink
              Color(0xFFA855F7), // Purple
              Color(0xFF3B82F6), // Blue
            ],
            tileMode: TileMode.repeated,
          ).createShader(bounds);
        },
        child: child);
  }
}
