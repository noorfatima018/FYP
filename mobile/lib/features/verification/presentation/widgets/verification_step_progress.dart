import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Multi-step progress bar with animated active pill and step counters
class VerificationStepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepTitle;

  const VerificationStepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top step label and indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STEP $currentStep OF $totalSteps • ${stepTitle.toUpperCase()}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.brownAccent,
                letterSpacing: 0.6,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.navyPrimary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Animated Bar
        Stack(
          children: [
            // Background Track
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.sandContainer,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Animated Foreground Fill
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.brownAccent, AppColors.navyPrimary],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
