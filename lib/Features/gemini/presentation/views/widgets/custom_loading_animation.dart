import 'package:bookly_app/Features/gemini/presentation/views/widgets/bot_icon.dart';
import 'package:bookly_app/core/utils/assets_data.dart';
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
          AssetsData.typingAnimation,
          width: 50,
          height: 50,
          // fit: BoxFit.cover,
        ),
      ],
    );
  }
}
