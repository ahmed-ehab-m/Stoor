import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CameraIcon extends StatelessWidget {
  const CameraIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: -1,
      right: -1,
      child: CircleAvatar(
        backgroundColor: Color(0xFFA855F7),
        child: Icon(
          HugeIcons.strokeRoundedCamera01,
          color: Colors.white,
        ),
      ),
    );
  }
}
