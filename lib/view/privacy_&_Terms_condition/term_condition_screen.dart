import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/privacy_&_Terms_condition/widget/legal_documents_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Updated March 15 2025",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),
            const LegalDocumentsSection(
              title: "1. Information we Collect",
              content:
                  "We collect various types of information to provide and improve our services. This includes personal information such as your name, email address, phone number, and payment details when you register or make a purchase. We may also collect non-personal data like device information, browser type, and interaction with our app for analytics and performance enhancement purposes.",
            ),
            const LegalDocumentsSection(
              title: "2. How We Use Your Information",
              content:
                  "Your information is used to deliver our services, process transactions, respond to inquiries, and improve user experience. We may also use your data to send relevant updates, promotional offers, or important account-related notices. Data collected for analytics helps us understand how users interact with our application.",
            ),
            const LegalDocumentsSection(
              title: "3. Sharing Your Information",
              content:
                  "We do not sell your personal information to third parties. However, we may share data with trusted partners who assist in operating our platform, conducting business, or servicing you, as long as those parties agree to keep this information confidential. We may also disclose information when legally required.",
            ),
            const LegalDocumentsSection(
              title: "4. Data Security",
              content:
                  "We implement a variety of security measures to maintain the safety of your personal information. These include encryption, secure servers, and regular system updates. However, no method of transmission over the Internet is 100% secure, and we cannot guarantee absolute security.",
            ),
            const LegalDocumentsSection(
              title: "5. Your Rights and Choices",
              content:
                  "You have the right to access, update, or delete your personal information at any time. You can manage your communication preferences or opt out of non-essential notifications. If you have concerns about how we handle your data, you may contact our support team for assistance.",
            ),
          ],
        ),
      ),
    );
  }
}
