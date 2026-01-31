import 'package:flutter/material.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/question/question_model.dart';

// Question card widget with answer options
class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final String? selectedAnswer;
  final bool? isCorrect;
  final bool showFeedback;
  final Function(String) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    this.selectedAnswer,
    this.isCorrect,
    this.showFeedback = false,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question text
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.applyOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.applyOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  question.difficulty.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              16.vBox,
              Text(
                question.question,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        24.vBox,

        // Feedback label
        if (showFeedback) ...[
          feedbackLabel(context),
          16.vBox,
        ],

        // Answer options
        ...question.allAnswers.map((answer) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AnswerOption(
              answer: answer,
              isSelected: selectedAnswer == answer,
              isCorrect: answer == question.correctAnswer,
              showFeedback: showFeedback,
              onTap: () => onAnswerSelected(answer),
            ),
          );
        }),
      ],
    );
  }

  Widget feedbackLabel(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: isCorrect == true
            ? AppColors.successLight
            : AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isCorrect == true ? Icons.check_circle : Icons.cancel,
            color: isCorrect == true ? AppColors.success : AppColors.error,
            size: 24,
          ),
          8.hBox,
          Text(
            isCorrect == true ? 'Correct!' : 'Incorrect!',
            style: TextStyle(
              color: isCorrect == true ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool showFeedback;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.showFeedback,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;
    IconData? icon;

    if (showFeedback) {
      if (isCorrect) {
        borderColor = AppColors.success;
        backgroundColor = AppColors.successLight;
        textColor = AppColors.success;
        icon = Icons.check_circle;
      } else if (isSelected && !isCorrect) {
        borderColor = AppColors.error;
        backgroundColor = AppColors.errorLight;
        textColor = AppColors.error;
        icon = Icons.cancel;
      } else {
        borderColor = AppColors.textTertiary.applyOpacity(0.3);
        backgroundColor = Colors.white;
        textColor = AppColors.textSecondary;
        icon = null;
      }
    } else {
      if (isSelected) {
        borderColor = AppColors.primary;
        backgroundColor = AppColors.primary.applyOpacity(0.1);
        textColor = AppColors.primary;
        icon = Icons.circle;
      } else {
        borderColor = AppColors.textTertiary.applyOpacity(0.3);
        backgroundColor = Colors.white;
        textColor = AppColors.textPrimary;
        icon = Icons.circle_outlined;
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: showFeedback ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: showFeedback
                      ? (isCorrect
                            ? AppColors.success
                            : (isSelected
                                  ? AppColors.error
                                  : AppColors.textTertiary))
                      : (isSelected
                            ? AppColors.primary
                            : AppColors.textTertiary),
                  size: 24,
                ),
                12.hBox,
              ],
              Expanded(
                child: Text(
                  answer,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
