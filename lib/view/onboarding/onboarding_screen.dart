import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/onboarding_item.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/services/storage_services.dart';
import 'package:e_learning/view/onboarding/widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingItem> _pages = [
    OnboardingItem(
      title: "Welcome to LearnEase",
      description:
          "Unlock the power of knowledge with our easy-to-use platform. Start your journey towards smarter learning today",
    ),
    OnboardingItem(
      title: "Engage, Explore, Exce",
      description:
          "Discover interactive courses, gain new skills, and explore content tailored to your learning goals.",
    ),
    OnboardingItem(
      title: "Learn Anywhere",
      description:
          "Learn at your own pace, anytime, anywhere. Let's make learning an enjoyable experience together!",
    ),
  ];
  void _compleatOnboarding() async {
    await StorageServices.setFirstTime(false);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(page: _pages[index]);
            },
          ),
          //skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _compleatOnboarding,
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //page indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const WormEffect(
                    dotColor: Colors.white54,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8,
                  ),
                ),
                //Next/Get started button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _compleatOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: Text(
                    _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
