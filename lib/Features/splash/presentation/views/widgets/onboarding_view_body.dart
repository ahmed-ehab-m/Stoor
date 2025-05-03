import 'package:bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Bookly",
          body: "Discover your next favorite book",
          // image: const Center(
          //   child: Icon(
          //     Icons.book,
          //     size: 100,
          //     color: Colors.blue,
          //   ),
          // ),
          image: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                image: AssetImage('assets/images/633.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            // child: Image.asset('assets/images/633.jpg')
          ),
        ),
        PageViewModel(
          title: "Explore a World of Books",
          body: "Find books from various genres and authors",
          // image: Image.asset('assets/images/onboarding2.png'),
        ),
        PageViewModel(
          title: "Join the Community",
          body: "Connect with fellow book lovers and share reviews",
          // image: Image.asset('assets/images/onboarding3.png'),
        ),
      ],
      onDone: () {
        GoRouter.of(context)
            .push(AppRouter.KMainView); // Navigate to the home screen
        // Navigate to the next screen
      },
      onSkip: () {
        GoRouter.of(context)
            .push(AppRouter.KMainView); // Navigate to the home screen

        // Navigate to the next screen
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
    );
  }
}
