import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/splash/presentation/views/manager/splash_cubit/splash_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/assetsData.dart';
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
    triggerAppStatus();
    // TODO: implement initState
    super.initState();
  }

  void triggerAppStatus() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.read<SplashCubit>().checkAppStatus();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImagesAndNavigate();
  }

  Future<void> _precacheImagesAndNavigate() async {
    try {
      // Precache images
      final pages = [
        AssetsData.onboardingImageOne,
        AssetsData.onboardingImageTwo,
      ];
      for (var image in pages) {
        await precacheImage(AssetImage(image), context);
      }
      // Navigate to OnboardingView after images are loaded
      // if (mounted) {
      //   GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
      // }
    } catch (e) {
      // Handle any errors and navigate anyway
      // if (mounted) {
      //   GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
      builder: (context, state) {
        return BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateToOnboarding) {
              GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
            } else if (state is SplashNavigateToHome) {
              GoRouter.of(context).pushReplacement(AppRouter.KMainView);
            } else if (state is SplashNavigateToSignUp) {
              GoRouter.of(context).pushReplacement(AppRouter.KSignupView);
            } else if (state is SplashError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: BlocProvider.of<ChangeSettingsCubit>(context)
                    .gradientColors,
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
