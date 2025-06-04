import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BotIcon extends StatelessWidget {
  const BotIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 8, top: 0),
      child: CustomShaderMask(
        child:
            Icon(HugeIcons.strokeRoundedRobot01, color: Colors.white, size: 30),
      ),
    );
  }
}
