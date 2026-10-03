import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../routes/app_routes.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../presentation/providers/verification_provider.dart';

class VerificationStatusScreen extends ConsumerWidget {
  const VerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleModeProvider);
    final verificationData = ref.watch(verificationProvider);
    final isRenter = roleState.activeRole == UserRole.renter;

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Success Icon Badge
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.successGreenBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.successGreenBorder, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.successGreen.withValues(alpha: 0.15),
                        blurRadius: 18,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    color: AppColors.successGreen,
                    size: 40,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Main Headline
              const Center(
                child: Text(
                  'KYC Documents\nSubmitted Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navyPrimary,
                    letterSpacing: -0.6,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  isRenter
                      ? 'Your profile is now queued for instant administrative verification. You can start exploring items immediately.'
                      : 'Your host identity and payout details are submitted. You can now begin listing your assets.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Trust Score Gauge Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderMuted, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navyPrimary.withValues(alpha: 0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Score & Level Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'INITIAL TRUST SCORE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.brownAccent,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${verificationData.trustScore}',
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.navyPrimary,
                                  ),
                                ),
                                const Text(
                                  '/100',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Tier Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.sandContainer,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.brownAccent.withValues(alpha: 0.3)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.shield_rounded, size: 14, color: AppColors.brownAccent),
                              SizedBox(width: 4),
                              Text(
                                'Tier 1 Verified',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.navyPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Divider(color: AppColors.borderMuted, thickness: 1),

                    const SizedBox(height: 12),

                    // Trust Factors List
                    _buildTrustFactor(
                      title: 'Base Registration',
                      pts: '+50 Pts',
                      isComplete: true,
                    ),
                    const SizedBox(height: 8),
                    _buildTrustFactor(
                      title: 'Mobile Phone OTP Verified',
                      pts: '+5 Pts',
                      isComplete: verificationData.isPhoneVerified,
                    ),
                    const SizedBox(height: 8),
                    _buildTrustFactor(
                      title: 'CNIC & Facial Liveness Verified',
                      pts: '+20 Pts',
                      isComplete: true,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Primary Continue Button
              AppButton(
                text: isRenter ? 'Start Exploring Rentals' : 'Go to Host Dashboard',
                onPressed: () {
                  final targetRoute = isRenter ? AppRoutes.renterHome : AppRoutes.ownerDashboard;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    targetRoute,
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTrustFactor({
    required String title,
    required String pts,
    required bool isComplete,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              isComplete ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 16,
              color: isComplete ? AppColors.successGreen : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.navyPrimary,
              ),
            ),
          ],
        ),
        Text(
          pts,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.brownAccent,
          ),
        ),
      ],
    );
  }
}
