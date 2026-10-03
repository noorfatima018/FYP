import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TrustBadgeChip extends StatelessWidget {
  final int score;
  final VoidCallback? onTap;

  const TrustBadgeChip({
    super.key,
    required this.score,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderMuted),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.successGreenBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shield_rounded,
                size: 13,
                color: AppColors.successGreen,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.navyPrimary,
              ),
            ),
            const Text(
              ' Trust',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.brownAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
