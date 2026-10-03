import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/models/user_role.dart';
import '../providers/role_mode_provider.dart';
import '../widgets/role_card.dart';
import '../../../../routes/app_routes.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final activeRole = ref.read(roleModeProvider).activeRole;
    ref.read(roleModeProvider.notifier).selectRole(activeRole);

    // Navigate to Verification Intro Flow
    Navigator.of(context).pushNamed(AppRoutes.verificationIntro);
  }

  @override
  Widget build(BuildContext context) {
    final roleState = ref.watch(roleModeProvider);
    final isRenter = roleState.activeRole == UserRole.renter;

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Tag Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.brownAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'STEP 1 OF 2 • CHOOSE EXPERIENCE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.brownAccent,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Main Heading
                  const Text(
                    'How will you use\nRentWise today?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navyPrimary,
                      letterSpacing: -0.8,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Select your primary mode to personalize your verification and dashboard. You can switch anytime.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Role Cards in Scrollable Area
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // Renter / Client Option
                        RoleCard(
                          role: UserRole.renter,
                          isSelected: isRenter,
                          icon: Icons.shopping_bag_outlined,
                          title: 'I want to Rent Items',
                          subtitle:
                              'Browse cameras, drones, electronics & tools with AI risk protection and verified owners.',
                          perks: const [
                            'Instant access to high-value equipment',
                            'Lower security deposits with verified identity',
                            'AI inspection & dispute protection',
                          ],
                          onSelect: () {
                            ref
                                .read(roleModeProvider.notifier)
                                .selectRole(UserRole.renter);
                          },
                        ),

                        const SizedBox(height: 16),

                        // Owner / Lender Option
                        RoleCard(
                          role: UserRole.owner,
                          isSelected: !isRenter,
                          icon: Icons.storefront_outlined,
                          title: 'I want to List & Earn',
                          subtitle:
                              'Monetize your unused assets safely with pre-screened renters, escrow deposits & insurance.',
                          perks: const [
                            'Earn steady passive income from gear',
                            'Pre-screened renters with Trust Score AI',
                            'Automated agreements & escrow payouts',
                          ],
                          onSelect: () {
                            ref
                                .read(roleModeProvider.notifier)
                                .selectRole(UserRole.owner);
                          },
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // Bottom Action Button
                  AppButton(
                    text: isRenter
                        ? 'Continue as Renter'
                        : 'Continue as Asset Owner',
                    onPressed: _handleContinue,
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
