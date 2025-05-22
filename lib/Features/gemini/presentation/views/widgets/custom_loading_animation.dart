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
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 190, 62, 212).withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShaderMask(
                child: Icon(
                  HugeIcons.strokeRoundedGoogleGemini,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              // Lottie.asset(
              //   AssetsData.circleAnimation,
              //   height: 50, // غيرها حسب المساحة اللي انت عايزها
              //   repeat: true,
              //   reverse: false,
              //   animate: true,
              // ),
              Text(
                "Thinking...",
                style: Styles.textStyle18,
              )
            ],
          ),
        ),
      ],
    );
  }
}
