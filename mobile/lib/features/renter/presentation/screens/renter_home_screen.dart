import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../role_mode/presentation/widgets/mode_switch_pill.dart';
import '../../../trust_profile/presentation/widgets/trust_badge_chip.dart';
import '../../../verification/presentation/providers/verification_provider.dart';
import '../../../../routes/app_routes.dart';

class RenterHomeScreen extends ConsumerStatefulWidget {
  const RenterHomeScreen({super.key});

  @override
  ConsumerState<RenterHomeScreen> createState() => _RenterHomeScreenState();
}

class _RenterHomeScreenState extends ConsumerState<RenterHomeScreen> {
  int _selectedCategoryIndex = 0;
  final categories = ['All Gear', 'Cameras', 'Drones', 'Audio & DJ', 'Power Tools', 'Laptops'];

  final featuredItems = [
    {
      'title': 'Sony FX3 Cinema Camera + 24-70mm G-Master',
      'category': 'Cameras',
      'rate': 'PKR 8,500',
      'period': '/day',
      'rating': '4.95',
      'reviews': '28',
      'owner': 'Hamza K.',
      'ownerScore': '92 Trust',
      'icon': Icons.camera_alt_rounded,
      'deposit': 'PKR 15,000 Deposit',
    },
    {
      'title': 'DJI Mini 4 Pro Fly More Combo (4K HDR)',
      'category': 'Drones',
      'rate': 'PKR 5,000',
      'period': '/day',
      'rating': '5.0',
      'reviews': '14',
      'owner': 'Zainab M.',
      'ownerScore': '88 Trust',
      'icon': Icons.flight_takeoff_rounded,
      'deposit': 'PKR 10,000 Deposit',
    },
    {
      'title': 'Yamaha 3.5kVA Inverter Silent Generator',
      'category': 'Power Tools',
      'rate': 'PKR 4,200',
      'period': '/day',
      'rating': '4.88',
      'reviews': '41',
      'owner': 'Bilal A.',
      'ownerScore': '95 Trust',
      'icon': Icons.bolt_rounded,
      'deposit': 'PKR 8,000 Deposit',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final verificationData = ref.watch(verificationProvider);

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Top Bar: User Info + Trust Badge + Mode Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back,',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Text(
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
                    // Trust Badge Chip (opens Trust Profile)
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

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderMuted),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search_rounded, color: AppColors.brownAccent, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search cameras, drones, tools...',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Icon(Icons.tune_rounded, color: AppColors.navyPrimary, size: 20),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // AI Risk Protection Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.navyPrimary, AppColors.navyLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyPrimary.withValues(alpha: 0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_outlined, color: AppColors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI-Protected P2P Rentals',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Automated condition photo inspection & escrow deposit protection on every booking.',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.creamBg,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category Chips List
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.navyPrimary : AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.navyPrimary : AppColors.borderMuted,
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected ? AppColors.white : AppColors.navyPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Featured Header Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured High-Value Gear',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navyPrimary,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brownAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Items List
            ...featuredItems.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
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
                      children: [
                        // Gear Icon Container
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.sandContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(item['icon'] as IconData, color: AppColors.brownAccent, size: 26),
                        ),

                        const SizedBox(width: 14),

                        // Title & Rating
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navyPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, size: 15, color: Colors.amber),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${item['rating']} (${item['reviews']} rentals)',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• ${item['ownerScore']}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.successGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Divider(color: AppColors.borderMuted, thickness: 0.8),
                    const SizedBox(height: 8),

                    // Price & Deposit Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              item['rate'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.navyPrimary,
                              ),
                            ),
                            Text(
                              item['period'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),

                        // Deposit Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.sandContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['deposit'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brownAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
