import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomNaviagationSection extends StatelessWidget {
  const CustomNaviagationSection(
      {super.key,
      required this.numberOfPages,
      required this.pageController,
      required this.currentPage});
  final int numberOfPages;
  final PageController pageController;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: numberOfPages,
              effect: ExpandingDotsEffect(
                activeDotColor: kPrimaryColor,
                dotColor: Colors.grey.withOpacity(0.5),
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentPage == 0
                ? Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushReplacement(AppRouter.KSignupView);
                        },
                        child: Text(
                          'Skip',
                          style: Styles.textStyle20.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kSecondaryColor),
                        ),
                      ),
                    ),
                  )
                : const Expanded(child: SizedBox()),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    currentPage == 1
                        ? GoRouter.of(context)
                            .pushReplacement(AppRouter.KSignupView)
                        : pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                  },
                  child: Text(
                    currentPage == 1 ? 'Get Started' : 'Next',
                    style: Styles.textStyle20.copyWith(
                        fontWeight: FontWeight.bold, color: kSecondaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
