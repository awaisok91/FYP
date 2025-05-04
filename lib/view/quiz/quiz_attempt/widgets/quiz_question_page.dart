import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/question.dart';
import 'package:e_learning/view/quiz/quiz_attempt/widgets/quiz_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/http/utils/body_decoder.dart';

class QuizQuestionPage extends StatelessWidget {
  final int questionNumber;
  final int totalQuestion;
  final Question question;
  final String? selectedOptionId;
  final Function(String) onOptionSelected;
  const QuizQuestionPage({
    super.key,
    required this.questionNumber,
    required this.totalQuestion,
    required this.question,
    this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Question $questionNumber of $totalQuestion",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            question.text,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 32),
          ...question.options.map(
            (option) => QuizOptionTile(
              optionId: option.id,
              text: option.text,
              isSelected: option.id == selectedOptionId,
              onTap: () => onOptionSelected(option.id),
              selectedOptionId: selectedOptionId,
            ),
          ),
        ],
      ),
    );
  }
}
