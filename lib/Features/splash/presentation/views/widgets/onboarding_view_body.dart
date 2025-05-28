import 'package:bookly_app/Features/splash/presentation/views/widgets/custom_naviagation_section.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/assetsData.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
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
        'image': AssetsData.aiGhostAnimation,
        'title': 'AI-Powered Book Picks',
        'subtitle':
            'Let Gemini suggest your next read from our collection, tailored just for you.',
      },
    ];
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.only(
          left: screenSizeHelper.horizontalPadding,
          right: screenSizeHelper.horizontalPadding,
          bottom: 10),
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
                        pages[index]['image'] == AssetsData.aiGhostAnimation
                            ? LottieBuilder.asset(
                                pages[index]['image']!,
                                width: screenSizeHelper.screenWidth * 0.8,
                                height: screenSizeHelper.screenHeight * 0.4,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                // margin: EdgeInsets.only(top: 50),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: AssetImage(pages[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Text(
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
          CustomNaviagationSection(
              numberOfPages: pages.length,
              pageController: _pageController,
              currentPage: _currentPage),
        ],
      ),
    );
  }
}
