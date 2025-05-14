import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/assetsData.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pages = [
      {
        'image': AssetsData.onboardingImageOne,
        'title': 'Explore a World of Books',
        'subtitle':
            'Discover your next favorite book and find books from various genres and authors.',
      },
      {
        'image': AssetsData.onboardingImageTwo,
        'title': 'AI-Powered Book Picks',
        'subtitle':
            'Let Gemini suggest your next read from our collection, tailored just for you.',
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                _currentPage = index;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return Column(
                  spacing: 20,
                  children: [
                    Stack(
                      children: [
                        // Image.asset('assets/images/onboardingImage1.png'),
                        Container(
                          // margin: EdgeInsets.only(top: 50),
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(pages[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (pages[index]['image'] ==
                            AssetsData.onboardingImageTwo)
                          Positioned(
                              right: -1,
                              bottom: -1,
                              child: CustomShaderMask(
                                child: Icon(
                                  HugeIcons.strokeRoundedStars,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              ))
                      ],
                    ),
                    pages[index]['image'] == AssetsData.onboardingImageTwo
                        ? CustomShaderMask(
                            child: Text(
                              pages[index]['title']!,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            pages[index]['title']!,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              // color: textColor,
                            ),
                          ),
                    Text(
                      pages[index]['subtitle']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
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
              _currentPage == 0
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
                                color: Color(0xFFA855F7)),
                          ),
                        ),
                      ),
                    )
                  : Expanded(child: SizedBox()),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _currentPage == 1
                          ? GoRouter.of(context)
                              .pushReplacement(AppRouter.KSignupView)
                          : _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                    },
                    child: Text(
                      _currentPage == 1 ? 'Get Started' : 'Next',
                      style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA855F7)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
