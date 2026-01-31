import 'package:flutter/material.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../core/theme/app_colors.dart';

class TimerBar extends StatelessWidget {
  final int timeRemaining;
  final int totalTime;

  const TimerBar({
    super.key,
    required this.timeRemaining,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    final progress = timeRemaining / totalTime;
    final isWarning = timeRemaining <= 15;
    final isDanger = timeRemaining <= 5;

    Color timerColor;
    if (isDanger) {
      timerColor = AppColors.timerDanger;
    } else if (isWarning) {
      timerColor = AppColors.timerWarning;
    } else {
      timerColor = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.applyOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, color: timerColor, size: 20),
                    8.hBox,
                    Text(
                      'Time Remaining',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    formatTime(timeRemaining),
                    key: ValueKey(timeRemaining),
                    style: TextStyle(
                      color: timerColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            12.vBox,
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final progressWidth = (availableWidth * progress).clamp(
                  0.0,
                  availableWidth,
                );

                return Stack(
                  children: [
                    // Background
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.textTertiary.applyOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Progress
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 8,
                      width: progressWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [timerColor, timerColor.applyOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: isDanger
                            ? [
                                BoxShadow(
                                  color: timerColor.applyOpacity(0.5),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
