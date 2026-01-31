import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../providers/quiz_provider.dart';
import 'dart:math' as math;

// Quiz result screen
class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController confettiController;
  late AnimationController scoreController;
  late Animation<double> scoreAnimation;

  @override
  void initState() {
    super.initState();
    confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    scoreAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: scoreController,
        curve: Curves.easeOutBack,
      ),
    );

    confettiController.repeat();
    scoreController.forward();
  }

  @override
  void dispose() {
    confettiController.dispose();
    scoreController.dispose();
    super.dispose();
  }

  void goHomeButton() {
    ref.read(quizProvider.notifier).resetQuiz();
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final result = quizState.result;
    final isMobile = context.isMobile;

    if (result == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              16.vBox,
              const Text('No quiz results available'),
              24.vBox,
              ElevatedButton(
                onPressed: goHomeButton,
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) goHomeButton();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    result.isPassed
                        ? AppColors.success.applyOpacity(0.1)
                        : AppColors.error.applyOpacity(0.1),
                    AppColors.background,
                  ],
                ),
              ),
            ),

            // Confetti animation (for passed)
            if (result.isPassed) confetti(),

            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 20 : 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.contentMaxWidth,
                    ),
                    child: Column(
                      children: [
                        24.vBox,

                        // Result badge
                        resultBadge(context, result),
                        32.vBox,

                        // Score card
                        scoreCard(context, result),
                        24.vBox,

                        // Stats row
                        statsRow(context, result, isMobile),
                        32.vBox,

                        // Action buttons
                        actionButtons(context),
                        24.vBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confetti() {
    return AnimatedBuilder(
      animation: confettiController,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(confettiController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget resultBadge(BuildContext context, result) {
    return AnimatedBuilder(
      animation: scoreAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scoreAnimation.value,
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: result.isPassed
                      ? const LinearGradient(
                          colors: [AppColors.success, Color(0xFF059669)],
                        )
                      : const LinearGradient(
                          colors: [AppColors.error, Color(0xFFDC2626)],
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: (result.isPassed ? AppColors.success : AppColors.error)
                          .applyOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    result.isPassed ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
              24.vBox,
              Text(
                result.isPassed ? 'Congratulations!' : 'Keep Trying!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: result.isPassed ? AppColors.success : AppColors.error,
                    ),
              ),
              8.vBox,
              Text(
                result.isPassed
                    ? 'You did an amazing job!'
                    : "Don't give up, practice makes perfect!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget scoreCard(BuildContext context, result) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: AppColors.textTertiary.applyOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              result.categoryName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            16.vBox,

            // Score circle
            AnimatedBuilder(
              animation: scoreAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        value: result.percentageScore / 100 * scoreAnimation.value,
                        strokeWidth: 12,
                        backgroundColor: AppColors.textTertiary.applyOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getScoreColor(result.percentageScore),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(result.percentageScore * scoreAnimation.value).toInt()}%',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: getScoreColor(result.percentageScore),
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getScoreColor(result.percentageScore)
                                .applyOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Grade ${result.grade}',
                            style: TextStyle(
                              color: getScoreColor(result.percentageScore),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
                        24.vBox,

            // Score earned
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 24),
                  8.hBox,
                  Text(
                    '+${result.scoreEarned} points',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsRow(BuildContext context, result, bool isMobile) {
    final stats = [
      {
        'icon': Icons.check_circle,
        'value': '${result.correctAnswers}/${result.totalQuestions}',
        'label': 'Correct',
        'color': AppColors.success,
      },
      {
        'icon': Icons.timer,
        'value': result.formattedTime,
        'label': 'Time',
        'color': AppColors.info,
      },
      {
        'icon': Icons.speed,
        'value': '${(result.timeTaken.inSeconds / result.totalQuestions).toStringAsFixed(1)}s',
        'label': 'Avg/Q',
        'color': AppColors.warning,
      },
    ];

    if (isMobile) {
      return Row(
        spacing: 10,
        children: stats
            .map((stat) => Expanded(
                  child: StatItem(
                    icon: stat['icon'] as IconData,
                    value: stat['value'] as String,
                    label: stat['label'] as String,
                    color: stat['color'] as Color,
                  ),
                ))
            .toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stats
          .map((stat) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StatItem(
                  icon: stat['icon'] as IconData,
                  value: stat['value'] as String,
                  label: stat['label'] as String,
                  color: stat['color'] as Color,
                ),
              ))
          .toList(),
    );
  }

  Widget actionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: goHomeButton,
            icon: const Icon(Icons.home),
            label: const Text('Back to Home'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Color getScoreColor(double percentage) {
    if (percentage >= 80) return AppColors.success;
    if (percentage >= 60) return AppColors.warning;
    return AppColors.error;
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatItem({super.key, 
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textTertiary.applyOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          8.vBox,
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for confetti animation
class ConfettiPainter extends CustomPainter {
  final double progress;
  final List<Confetti> confetti = [];
  final math.Random random = math.Random(42);

  ConfettiPainter(this.progress) {
    // Generate confetti pieces
    for (int i = 0; i < 50; i++) {
      confetti.add(Confetti(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 10 + 5,
        color: getRandomColor(),
        speed: random.nextDouble() * 0.5 + 0.3,
        rotation: random.nextDouble() * math.pi * 2,
      ));
    }
  }

  Color getRandomColor() {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      AppColors.warning,
      AppColors.accent,
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final c in confetti) {
      final paint = Paint()..color = c.color.applyOpacity(0.8);
      final y = (c.y + progress * c.speed) % 1.0 * size.height;
      final x = c.x * size.width + math.sin(progress * math.pi * 2 + c.rotation) * 30;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * math.pi * 2 + c.rotation);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: c.size, height: c.size / 2),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class Confetti {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double speed;
  final double rotation;

  Confetti({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
    required this.rotation,
  });
}
