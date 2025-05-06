import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: Column(
        spacing: 20,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                image: AssetImage('assets/images/Group 6.png'),
                fit: BoxFit.cover,
              ),
            ),
            // child: Image.asset('assets/images/633.jpg')
          ),
          Text(
            "Explore a World of Books",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              // color: textColor,
            ),
          ),
          Text(
            "Discover your next favorite book and Find books from various genres and authors",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // color: textColor,
            ),
          ),
          const Spacer(),
          CustomButton(
            borderRadius: BorderRadius.circular(10),
            backGroundColor: kPrimaryColor,
            textColor: Colors.white,
            text: 'Get Started',
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KSignupView);
            },
          ),
        ],
      ),
    );
    // return IntroductionScreen(
    //   dotsDecorator: const DotsDecorator(
    //     size: Size(10, 10),
    //     activeSize: Size(20, 10),
    //     activeColor: Colors.white,
    //     color: Colors.grey,
    //     spacing: EdgeInsets.symmetric(horizontal: 5),
    //   ),
    //   pages: [
    //     PageViewModel(
    //       titleWidget: Text(
    //         "Explore a World of Books",
    //         style: TextStyle(
    //           fontSize: 50,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //         ),
    //       ),
    //       bodyWidget: Text(
    //         "Discover your next favorite book ,Find books from various genres and authors",
    //         style: TextStyle(
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //         ),
    //       ),
    //       image: Container(
    //         // margin: const EdgeInsets.only(top: 0, right: 0, left: 0),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(50),
    //           image: const DecorationImage(
    //             image: AssetImage('assets/images/Group 6.png'),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         // child: Image.asset('assets/images/633.jpg')
    //       ),
    //     ),
    //     PageViewModel(
    //       titleWidget: Text(
    //         "Explore a World of Books",
    //         style: TextStyle(
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //         ),
    //       ),
    //       body: "Find books from various genres and authors",
    //       // image: Image.asset('assets/images/onboarding2.png'),
    //     ),
    //     PageViewModel(
    //       title: "Join the Community",
    //       body: "Connect with fellow book lovers and share reviews",
    //       // image: Image.asset('assets/images/onboarding3.png'),
    //     ),
    //   ],
    //   onDone: () {
    //     GoRouter.of(context)
    //         .push(AppRouter.KMainView); // Navigate to the home screen
    //     // Navigate to the next screen
    //   },
    //   onSkip: () {
    //     GoRouter.of(context)
    //         .push(AppRouter.KSignupView); // Navigate to the home screen

    //     // Navigate to the next screen
    //   },
    //   showSkipButton: true,
    //   skip: const Text("Skip"),
    //   next: const Icon(Icons.arrow_forward),
    //   done: const Text("Done"),
    // );
  }
}
