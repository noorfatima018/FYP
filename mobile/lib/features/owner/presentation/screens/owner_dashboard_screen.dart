import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../role_mode/presentation/widgets/mode_switch_pill.dart';
import '../../../trust_profile/presentation/widgets/trust_badge_chip.dart';
import '../../../verification/presentation/providers/verification_provider.dart';
import '../../../../routes/app_routes.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationData = ref.watch(verificationProvider);

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Host Portal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'Areeba Arif',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navyPrimary,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    TrustBadgeChip(
                      score: verificationData.trustScore,
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.trustProfile);
                      },
                    ),
                    const SizedBox(width: 8),
                    const ModeSwitchPill(),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Earnings & Metric Stats Overview
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.navyPrimary, AppColors.navyLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyPrimary.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL RENTAL EARNINGS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamBg,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PKR 48,500',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetricItem('Active Listings', '3 Items'),
                      _buildMetricItem('Pending Requests', '1 New'),
                      _buildMetricItem('On-Time Payouts', '100%'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action: List New Asset
            AppButton(
              text: '+ List New Rental Asset',
              backgroundColor: AppColors.brownAccent,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.navyPrimary,
                    content: Text(
                      'Asset Listing feature ready for onboarding!',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Pending Rental Request Section with AI Risk Assessment
            const Text(
              'Pending Booking Requests',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyPrimary,
              ),
            ),

            const SizedBox(height: 10),

            // Request Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.borderMuted),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sony Alpha A7 IV Camera',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navyPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.successGreenBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.successGreenBorder),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shield_rounded, size: 12, color: AppColors.successGreen),
                            SizedBox(width: 4),
                            Text(
                              'AI: Low Risk',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.successGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Renter: Hamza Siddiqui • 88 Trust Score • CNIC Verified',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.sandContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duration: Oct 10 - Oct 13 (3 Days)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.navyPrimary)),
                        Text('Payout: PKR 18,000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.navyPrimary)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.errorRed,
                            side: const BorderSide(color: AppColors.errorRedBorder),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Decline', style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navyPrimary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Approve & Sign', style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Active Inventory Section
            const Text(
              'Your Active Listings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyPrimary,
              ),
            ),

            const SizedBox(height: 10),

            _buildInventoryTile('Sony Alpha A7 IV (Body Only)', 'Cameras', 'PKR 6,000/day', 'Available'),
            const SizedBox(height: 8),
            _buildInventoryTile('DJI Ronin RS3 Gimbal Stabilizer', 'Accessories', 'PKR 3,500/day', 'Rented Out'),
            const SizedBox(height: 8),
            _buildInventoryTile('Aputure 300d II Cinema Light', 'Lighting', 'PKR 4,000/day', 'Available'),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildMetricItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.creamBg,
          ),
        ),
      ],
    );
  }

  static Widget _buildInventoryTile(String title, String category, String rate, String status) {
    final isRented = status == 'Rented Out';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              const SizedBox(height: 2),
              Text(
                '$category • $rate',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isRented ? AppColors.sandContainer : AppColors.successGreenBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isRented ? AppColors.brownAccent : AppColors.successGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
