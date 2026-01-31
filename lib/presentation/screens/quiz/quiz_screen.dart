import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/quiz_state/quiz_state_model.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/countdown_overlay.dart';
import '../../widgets/question_card.dart';
import '../../widgets/timer_bar.dart';

// Quiz screen with gameplay flow
class QuizScreen extends ConsumerStatefulWidget {
  final int categoryId;
  final String categoryName;

  const QuizScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(quizProvider.notifier)
          .startQuiz(widget.categoryId, widget.categoryName);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleBack() {
    ref.read(quizProvider.notifier).resetQuiz();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final isMobile = context.isMobile;

    ref.listen<QuizStateModel>(quizProvider, (previous, next) {
      if (next.status == QuizStatus.completed) {
        context.push(AppRoutes.result);
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showExitConfirmation();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.applyOpacity(0.05),
                AppColors.background,
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Main content
                quizContent(context, quizState, isMobile),

                // Countdown
                if (quizState.status == QuizStatus.countdown)
                  CountdownOverlay(value: quizState.countdownValue),

                // Loading
                if (quizState.status == QuizStatus.loading) loading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quizContent(
    BuildContext context,
    QuizStateModel quizState,
    bool isMobile,
  ) {
    if (quizState.status == QuizStatus.error) {
      return errorState(quizState.errorMessage);
    }

    // Handle initial, loading, and countdown states
    if (quizState.status == QuizStatus.initial ||
        quizState.status == QuizStatus.loading ||
        quizState.status == QuizStatus.countdown) {
      return preQuizState(quizState, isMobile);
    }

    if (quizState.currentQuestion == null) {
      return preQuizState(quizState, isMobile);
    }

    return Column(
      children: [
        header(context, quizState, isMobile),

        // Question content
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 20 : 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
                child: QuestionCard(
                  question: quizState.currentQuestion!,
                  selectedAnswer: quizState.selectedAnswer,
                  isCorrect: quizState.isCorrect,
                  showFeedback: quizState.status == QuizStatus.showingFeedback,
                  onAnswerSelected: (answer) {
                    if (quizState.status == QuizStatus.inProgress) {
                      ref.read(quizProvider.notifier).submitAnswer(answer);
                    }
                  },
                ),
              ),
            ),
          ),
        ),

        // Timer bar
        TimerBar(
          timeRemaining: quizState.timeRemainingSeconds,
          totalTime: AppConstants.questionTimeSeconds,
        ),
      ],
    );
  }

  Widget header(BuildContext context, QuizStateModel quizState, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        children: [
          Row(
            children: [
              // Back button
              IconButton(
                onPressed: showExitConfirmation,
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.textPrimary,
                ),
              ),
              12.hBox,

              // Category name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizState.categoryName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      quizState.progressText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress percentage
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${quizState.progressPercentage.toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          16.vBox,

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: quizState.progressPercentage / 100,
              backgroundColor: AppColors.textTertiary.applyOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget preQuizState(QuizStateModel quizState, bool isMobile) {
    final categoryName = quizState.categoryName.isNotEmpty
        ? quizState.categoryName
        : widget.categoryName;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.quiz, size: 48, color: Colors.white),
          ),
          24.vBox,
          Text(
            categoryName,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          8.vBox,
          Text(
            quizState.status == QuizStatus.loading
                ? 'Loading questions...'
                : 'Get ready!',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Container(
      color: Colors.white.applyOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            16.vBox,
            Text(
              'Loading questions...',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorState(String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            24.vBox,
            Text(
              'Oops! Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            8.vBox,
            Text(
              errorMessage ?? 'Failed to load questions',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            24.vBox,
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                OutlinedButton(
                  onPressed: handleBack,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                  ),
                  child: const Text('Go Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(quizProvider.notifier)
                        .startQuiz(widget.categoryId, widget.categoryName);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Quiz?'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              handleBack();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
