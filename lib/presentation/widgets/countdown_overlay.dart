import 'package:flutter/material.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../core/theme/app_colors.dart';

// Countdown overlay widget for quiz start
class CountdownOverlay extends StatefulWidget {
  final int value;

  const CountdownOverlay({
    super.key,
    required this.value,
  });

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    controller.forward();
  }

  @override
  void didUpdateWidget(CountdownOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      controller.reset();
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.applyOpacity(0.95),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Ready!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white.applyOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            24.hBox,
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.applyOpacity(0.2),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.value}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            48.hBox,
            Text(
              widget.value == 1 ? 'GO!' : 'Starting soon...',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white.applyOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
