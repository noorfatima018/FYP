import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../../role_mode/presentation/widgets/mode_switch_pill.dart';
import '../../../../routes/app_routes.dart';

class VerificationIntroScreen extends ConsumerWidget {
  const VerificationIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleModeProvider);
    final isRenter = roleState.activeRole == UserRole.renter;

    final steps = isRenter
        ? [
            {
              'icon': Icons.phone_android_rounded,
              'title': 'Phone OTP Verification',
              'desc': 'Quick SMS confirmation to secure your communications.',
            },
            {
              'icon': Icons.badge_outlined,
              'title': 'CNIC Government ID',
              'desc': 'Capture front & back of your National ID card.',
            },
            {
              'icon': Icons.face_retouching_natural_outlined,
              'title': 'Selfie Liveness Check',
              'desc': 'Quick facial scan to match with your ID card photo.',
            },
          ]
        : [
            {
              'icon': Icons.phone_android_rounded,
              'title': 'Phone OTP Verification',
              'desc': 'Verify active mobile number for rental handover coordination.',
            },
            {
              'icon': Icons.badge_outlined,
              'title': 'CNIC Government ID',
              'desc': 'National identity verification for legal protection & trust.',
            },
            {
              'icon': Icons.face_retouching_natural_outlined,
              'title': 'Selfie Liveness Check',
              'desc': 'Facial matching for Verified Host badge status.',
            },
            {
              'icon': Icons.account_balance_wallet_outlined,
              'title': 'Payout Account Setup',
              'desc': 'Bank IBAN or JazzCash/Easypaisa to receive rental earnings.',
            },
          ];

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navyPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(child: ModeSwitchPill()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Badge & Trust Shield
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.brownAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isRenter ? 'RENTER VERIFICATION' : 'OWNER VERIFICATION',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.brownAccent,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),

                  // Trust Bonus Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successGreenBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.successGreenBorder),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined, size: 14, color: AppColors.successGreen),
                        SizedBox(width: 4),
                        Text(
                          '+25 Trust Points',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.successGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                isRenter ? 'Unlock Verified\nRental Access' : 'Become a Verified\nAsset Host',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.8,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isRenter
                    ? 'Complete quick identity verification to unlock higher rental limits and reduced security deposits.'
                    : 'Verify your identity to activate asset listings, receive damage protection, and automate bank payouts.',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Steps Card List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: steps.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderMuted, width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Step Number & Icon
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.sandContainer,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              step['icon'] as IconData,
                              size: 22,
                              color: AppColors.brownAccent,
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Text Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'STEP ${index + 1}: ',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.brownAccent,
                                      ),
                                    ),
                                    Text(
                                      step['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.navyPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  step['desc'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Actions
              AppButton(
                text: 'Begin Verification',
                onPressed: () {
                  // Navigate to Step 1: Phone Verification
                  Navigator.of(context).pushNamed(AppRoutes.phoneVerification);
                },
              ),

              const SizedBox(height: 8),

              Center(
                child: TextButton(
                  onPressed: () {
                    // Skip for now / explore dashboard with baseline score
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'I will verify later',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brownAccent,
                    ),
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
