import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/user_role.dart';
import '../providers/role_mode_provider.dart';

/// Reusable Mode Switch Pill (e.g. Switch between Renter and Owner modes on the fly)
class ModeSwitchPill extends ConsumerWidget {
  const ModeSwitchPill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleModeProvider);
    final isRenter = roleState.activeRole == UserRole.renter;

    return GestureDetector(
      onTap: () {
        ref.read(roleModeProvider.notifier).switchMode();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.sandContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderMuted, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRenter ? Icons.shopping_bag_outlined : Icons.storefront_outlined,
              size: 16,
              color: AppColors.navyPrimary,
            ),
            const SizedBox(width: 6),
            Text(
              isRenter ? 'Renter Mode' : 'Owner Mode',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.navyPrimary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.swap_horiz_rounded,
              size: 16,
              color: AppColors.brownAccent,
            ),
          ],
        ),
      ),
    );
  }
}
