import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Animated Circular Arc Gauge displaying the user's Trust Score (0 to 100)
class TrustScoreGauge extends StatefulWidget {
  final int score;
  final double size;
  final bool animate;

  const TrustScoreGauge({
    super.key,
    required this.score,
    this.size = 180,
    this.animate = true,
  });

  @override
  State<TrustScoreGauge> createState() => _TrustScoreGaugeState();
}

class _TrustScoreGaugeState extends State<TrustScoreGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    final targetProgress = (widget.score / 100.0).clamp(0.0, 1.0);
    _animation = Tween<double>(begin: 0.0, end: targetProgress).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = targetProgress;
    }
  }

  @override
  void didUpdateWidget(covariant TrustScoreGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      final targetProgress = (widget.score / 100.0).clamp(0.0, 1.0);
      _animation = Tween<double>(begin: _animation.value, end: targetProgress).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentScore = (_animation.value * 100).toInt();

          return Stack(
            alignment: Alignment.center,
            children: [
              // Custom Arc Painter
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _GaugePainter(
                  progress: _animation.value,
                  trackColor: AppColors.sandContainer,
                  gradientColors: currentScore >= 75
                      ? const [AppColors.brownAccent, AppColors.successGreen, AppColors.navyPrimary]
                      : const [AppColors.brownAccent, AppColors.navyPrimary],
                ),
              ),

              // Center Score & Label
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$currentScore',
                    style: TextStyle(
                      fontSize: widget.size * 0.26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyPrimary,
                      height: 1.0,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'TRUST SCORE',
                    style: TextStyle(
                      fontSize: widget.size * 0.065,
                      fontWeight: FontWeight.w800,
                      color: AppColors.brownAccent,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: currentScore >= 75 ? AppColors.successGreenBg : AppColors.sandContainer,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: currentScore >= 75
                            ? AppColors.successGreenBorder
                            : AppColors.borderMuted,
                      ),
                    ),
                    child: Text(
                      currentScore >= 75 ? 'Tier 1 Verified' : 'Baseline Trust',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: currentScore >= 75 ? AppColors.successGreen : AppColors.navyPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final List<Color> gradientColors;

  _GaugePainter({
    required this.progress,
    required this.trackColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const strokeWidth = 14.0;
    const startAngle = 0.75 * pi; // Start at bottom-left
    const sweepAngle = 1.5 * pi;  // Sweep 270 degrees

    // 1. Draw Background Track Arc
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    // 2. Draw Progress Arc with Gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: gradientColors,
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.trackColor != trackColor;
  }
}
