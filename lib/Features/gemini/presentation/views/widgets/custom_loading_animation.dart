import 'package:bookly_app/Features/gemini/presentation/views/widgets/bot_icon.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BotIcon(),
        Lottie.asset(
          "assets/animations/Animation - 1748187284463.json",
          width: 50,
          height: 50,
          // fit: BoxFit.cover,
        ),
        // child: Text(
        //   "Thinking...",
        //   style: Styles.textStyle18,
        // ),
      ],
    );
  }
}
