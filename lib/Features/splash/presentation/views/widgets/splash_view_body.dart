import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> slidingAnimation;
  @override
  void initState() {
    initSlidingAnimation();

    navigateToOnboarding();
    // slidingAnimation.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // colors: [
              //   kPrimaryColor, // بنفسجي غامق جدًا
              //   Color.fromRGBO(46, 26, 71, 1), // بنفسجي غامق
              //   Color.fromRGBO(75, 46, 107, 1), // بنفسجي داكن متوسط
              // ]
              colors:
                  BlocProvider.of<ChangeSettingsCubit>(context).gradientColors,
              ////for Dark Theme
              // Color.fromRGBO(134, 24, 157, 1),
              // Color.fromRGBO(46, 26, 71, 1),
              // Color.fromRGBO(75, 46, 107, 1),
              ////for Light Theme
              // Color.fromRGBO(156, 39, 176, 1),
              // Color.fromRGBO(168, 85, 247, 1),
              // Color.fromRGBO(107, 70, 193, 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [kPrimaryColor, Colors.white],
                        tileMode: TileMode.repeated,
                      ).createShader(bounds);
                    },
                    child: Icon(HugeIcons.strokeRoundedBookOpen02,
                        color: Colors.white, size: 200),
                  ),
                ),
                Text('Stoor',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'DancingScript-VariableFont_wght',
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center),
                // SlidingText(slidingAnimation: slidingAnimation),
              ],
            ),
          ),
        );
      },
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // TODO: implement initState
    super.initState();
    slidingAnimation = Tween<Offset>(begin: Offset(0, 2), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
    // slidingAnimation.addListener(() {
    //   setState(() {});
    // });
  }

  void navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
      // Get.to(() => const HomeView(),
      //     transition: Transition.fadeIn, duration: KTransationDuration);
    });
  }
}
