import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AiGhostAnimation extends StatelessWidget {
  const AiGhostAnimation(
      {super.key, required this.screenSizeHelper, required this.animation});
  final ScreenSizeHelper screenSizeHelper;
  final String animation;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          focalRadius: 0.8,
          colors: [
            // Color.fromARGB(255, 1, 85, 202),
            Color(0xFFA855F7), // Purple

            BlocProvider.of<ChangeSettingsCubit>(context)
                .backgroundColor!, // أزرق غامق (أعلى)
          ],
          // stops: [0.0, 0.5, 1.0],
          // stops: [0.0, 0.4, 0.8, 1.0],
        ),
      ),
      child: LottieBuilder.asset(
        animation,
        // width: screenSizeHelper.screenWidth * 8,
        height: screenSizeHelper.screenHeight * 0.5,
        fit: BoxFit.contain,
      ),
    );
  }
}
