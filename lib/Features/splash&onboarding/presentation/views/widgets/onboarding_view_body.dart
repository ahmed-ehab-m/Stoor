import 'package:bookly_app/Features/splash&onboarding/presentation/views/widgets/ai_ghost_animation.dart';
import 'package:bookly_app/Features/splash&onboarding/presentation/views/widgets/custom_naviagation_section.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/assets_data.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';

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
        'image': AssetsData.onBoardingImageTwo,
        'title': 'AI-Powered Book Picks',
        'subtitle':
            'Let AI Bot suggest your next read from our collection, tailored just for you.',
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
                  children: [
                    pages[index]['image'] == AssetsData.onBoardingImageTwo
                        ? AiGhostAnimation(
                            screenSizeHelper: screenSizeHelper,
                            animation: pages[index]['image']!,
                          )
                        : Stack(
                            children: [
                              Container(
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
                    pages[index]['image'] == AssetsData.onBoardingImageTwo
                        ? CustomShaderMask(
                            child: Text(
                              pages[index]['title']!,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            pages[index]['title']!,
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    Text(
                      pages[index]['subtitle']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
