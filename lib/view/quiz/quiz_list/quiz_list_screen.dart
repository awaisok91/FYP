import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:e_learning/view/quiz/quiz_list/widgets/quiz_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: AppColors.primary,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(16),
              title: Text(
                "Quizzes",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Welcome to the Quiz Section",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final quiz = DummyDataService.quizzes[index];
                  return QuizCard(
                    title: quiz.title,
                    description: quiz.description,
                    questionCount: quiz.questions.length,
                    timeLimit: quiz.timeLimit,
                    onTap: () => Get.toNamed(
                      "/quiz/${quiz.id}",
                      parameters: {"id": quiz.id},
                    ),
                  );
                },
                childCount: DummyDataService.quizzes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
