import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DocumentUploadBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const DocumentUploadBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return GestureDetector(
      onTap: hasImage ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 155,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hasImage ? AppColors.white : AppColors.sandContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasImage ? AppColors.successGreen : AppColors.borderMuted,
            width: hasImage ? 1.8 : 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: hasImage
            ? Stack(
                children: [
                  // Captured Document Preview Representation
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.successGreenBg,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.successGreenBorder),
                          ),
                          child: const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.successGreen,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$title Attached',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Ready for automated verification',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Retake Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: onClear,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.errorRedBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.errorRedBorder),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh_rounded, size: 12, color: AppColors.errorRed),
                            SizedBox(width: 4),
                            Text(
                              'Retake',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.errorRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Camera Icon Badge
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderMuted),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.brownAccent,
                      size: 22,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyPrimary,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
