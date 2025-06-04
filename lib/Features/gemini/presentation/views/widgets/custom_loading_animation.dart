import 'package:bookly_app/Features/gemini/presentation/views/widgets/bot_icon.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BotIcon(),
        Lottie.asset(
          "assets/animations/typingAnimation.json",
          width: 50,
          height: 50,
          // fit: BoxFit.cover,
        ),
      ],
    );
  }
}
