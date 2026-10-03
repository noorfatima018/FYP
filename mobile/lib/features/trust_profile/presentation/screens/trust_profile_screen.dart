import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../../role_mode/presentation/widgets/mode_switch_pill.dart';
import '../../../verification/presentation/providers/verification_provider.dart';
import '../widgets/trust_score_gauge.dart';

class TrustProfileScreen extends ConsumerWidget {
  const TrustProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleModeProvider);
    final verificationData = ref.watch(verificationProvider);
    final isRenter = roleState.activeRole == UserRole.renter;

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Trust Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.navyPrimary,
          ),
        ),
        centerTitle: true,
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderMuted),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.navyPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.brownAccent, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        'AA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Name & Role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Areeba Arif',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navyPrimary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: AppColors.successGreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isRenter ? 'Verified Client / Renter' : 'Verified Asset Owner',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Main Trust Gauge Center Box
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.borderMuted, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyPrimary.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TrustScoreGauge(
                    score: verificationData.trustScore,
                    size: 190,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    verificationData.trustScore >= 75
                        ? 'High Trust Rating (Top 15%)'
                        : 'Standard Trust Rating',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Calculated via real-time biometric & behavioral AI risk evaluation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Unlocked Perks Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.sandContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderMuted),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'UNLOCKED TRUST PRIVILEGES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.brownAccent,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPerkRow(
                    Icons.security_rounded,
                    'Reduced Security Deposit',
                    'Pay up to 50% less deposit on DSLR cameras, drones & gear.',
                  ),
                  const SizedBox(height: 8),
                  _buildPerkRow(
                    Icons.bolt_rounded,
                    'Instant Rental Approvals',
                    'Skip manual host checks on items under PKR 150,000.',
                  ),
                  const SizedBox(height: 8),
                  _buildPerkRow(
                    Icons.verified_user_outlined,
                    'Verified Identity Shield',
                    'Special trust shield badge displayed on all your offers.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Score Breakdown Title
            const Text(
              'TRUST SCORE FACTORS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.brownAccent,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 10),

            // Factor Cards
            _buildFactorCard('Base Registration', '+50 Pts', true, 'Identity profile initialized'),
            const SizedBox(height: 8),
            _buildFactorCard('Phone OTP Confirmed', '+5 Pts', verificationData.isPhoneVerified, 'Direct contact line secured'),
            const SizedBox(height: 8),
            _buildFactorCard('Government CNIC & Face Liveness', '+20 Pts', true, 'Full identity verification approved'),
            const SizedBox(height: 8),
            _buildFactorCard('On-Time Returns History', '+10 Pts', false, 'Complete 3 successful rentals without delay'),
            const SizedBox(height: 8),
            _buildFactorCard('5-Star Host Reviews', '+15 Pts', false, 'Maintain 4.8+ rating from item owners'),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _buildPerkRow(IconData icon, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.navyPrimary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navyPrimary,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildFactorCard(String title, String pts, bool isComplete, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isComplete ? AppColors.successGreenBorder : AppColors.borderMuted,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isComplete ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
                size: 18,
                color: isComplete ? AppColors.successGreen : AppColors.textMuted,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            pts,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isComplete ? AppColors.successGreen : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
