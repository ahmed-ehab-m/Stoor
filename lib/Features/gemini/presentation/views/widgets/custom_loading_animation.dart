import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 0),
          child: CustomShaderMask(
            child: Icon(HugeIcons.strokeRoundedStars,
                color: Colors.white, size: 25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA855F7).withOpacity(0.5),
                Color(0xFFA855F7).withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Text(
            "Thinking...",
            style: Styles.textStyle18,
          ),
        ),
      ],
    );
  }
}
