import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingItem page;
  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.4,
              padding: const EdgeInsets.all(32),
              child: Image.asset(
                "tools/images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),
            //title
            Text(
              page.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            //description
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                page.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
