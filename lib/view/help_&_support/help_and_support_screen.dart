import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/help_&_support/widget/contact_tile.dart';
import 'package:e_learning/view/help_&_support/widget/faq_tile.dart';
import 'package:e_learning/view/help_&_support/widget/help_search_bar.dart';
import 'package:e_learning/view/help_&_support/widget/help_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HelpSearchBar(),
              const SizedBox(height: 24),
              const HelpSection(
                title: "Frequently Asked Question",
                chidren: [
                  FaqTile(
                    question: 'How do I enroll in a course?',
                    answer:
                        'To enroll, browse the Courses section, select your desired course, and tap the "Enroll" button.',
                  ),
                  FaqTile(
                    question: 'Are there any free courses available?',
                    answer:
                        'Yes, we offer several free courses. Go to the "Free Courses" section to explore them.',
                  ),
                  FaqTile(
                    question:
                        'Can I get a certificate after completing a course?',
                    answer:
                        'Yes, you will receive a certificate after successfully completing all lessons and passing the final quiz.',
                  ),
                  FaqTile(
                    question: 'How can I track my progress?',
                    answer:
                        'Your progress is automatically tracked. Visit the "My Courses" section to view your current status.',
                  ),
                  FaqTile(
                    question: 'What should I do if a video is not playing?',
                    answer:
                        'Try checking your internet connection and restarting the app. If the problem persists, contact our support team.',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              HelpSection(title: "Contact Us", chidren: [
                ContactTile(
                  title: 'Support Team',
                  subTitle: 'awaisok91@gmail.com',
                  icon: Icons.email_outlined,
                  onTap: () {},
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
