import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/splash&onboarding/presentation/views/manager/splash_cubit/splash_cubit.dart';
import 'package:bookly_app/Features/splash&onboarding/presentation/views/widgets/custom_logo_animation.dart';
import 'package:bookly_app/Features/splash&onboarding/presentation/views/widgets/custom_text_animation.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late final AnimationController _logoAnimationController;
  late final AnimationController _textAnimationController;

  // Logo animations
  late final Animation<double> _logoSizeAnimation;
  late final Animation<double> _logoPositionAnimation;

  // Text animations
  late final Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    triggerAppStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImagesAndNavigate();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
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
              // GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
              GoRouter.of(context).pushReplacement(AppRouter.KMainView);
            } else if (state is SplashNavigateToSignUp) {
              // GoRouter.of(context).pushReplacement(AppRouter.KSignupView);
              GoRouter.of(context).pushReplacement(AppRouter.KOnboardingView);
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
                stops: const [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: BlocProvider.of<ChangeSettingsCubit>(context)
                    .gradientColors,
              ),
            ),
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _logoAnimationController,
                _textAnimationController,
              ]),
              builder: (context, child) {
                return Stack(
                  children: [
                    // Logo
                    CustomLogoAnimation(
                      logoAnimationController: _logoAnimationController,
                      logoSizeAnimation: _logoSizeAnimation,
                      logoPositionAnimation: _logoPositionAnimation,
                    ),
                    // النص (يظهر على شمال اللوجو)
                    CustomTextAnimation(
                      textAnimationController: _textAnimationController,
                      textOpacityAnimation: _textOpacityAnimation,
                      logoPositionAnimation: _logoPositionAnimation,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  ////////////////////////Pre Cache Images//////////////////////////
  Future<void> _precacheImagesAndNavigate() async {
    try {
      final pages = [
        AssetsData.onboardingImageOne,
        AssetsData.aiGhostAnimation,
      ];
      for (var image in pages) {
        await precacheImage(AssetImage(image), context);
      }
    } catch (e) {
      // Handle any errors
    }
  }

  /////////////////////Trigger App Status//////////////////////////
  void triggerAppStatus() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.read<SplashCubit>().checkAppStatus();
      }
    });
  }

////////////////Animations Functions///////////////
  void _initAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Logo size animation
    _logoSizeAnimation = Tween<double>(
      begin: 200.0,
      end: 60.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    // Logo position animation (يتحرك نصف المسافة لليمين عشان يكون في المنتصف مع النص)
    _logoPositionAnimation = Tween<double>(
            begin: 0.0, // في المنتصف
            end: -80 // يتحرك لليمين نصف المسافة الكلية
            )
        .animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    // Text opacity animation
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOut,
    ));

    // بدء الـ animation بعد ثانية واحدة
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _logoAnimationController.forward();

        // بدء الـ text animation مع حركة اللوجو
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _textAnimationController.forward();
          }
        });
      }
    });
  }
}
