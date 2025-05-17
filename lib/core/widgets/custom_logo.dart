import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [kPrimaryColor, Colors.grey],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: Icon(HugeIcons.strokeRoundedBookOpen02,
          color: Colors.white, size: 100),
    );
  }
}
