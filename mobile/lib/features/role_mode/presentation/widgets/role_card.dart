import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/user_role.dart';

class RoleCard extends StatefulWidget {
  final UserRole role;
  final bool isSelected;
  final VoidCallback onSelect;
  final String title;
  final String subtitle;
  final List<String> perks;
  final IconData icon;

  const RoleCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onSelect,
    required this.title,
    required this.subtitle,
    required this.perks,
    required this.icon,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? AppColors.navyPrimary : AppColors.borderMuted,
              width: isSelected ? 2.0 : 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.navyPrimary.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Icon Badge + Radio/Check Indicator)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon Circle Badge
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.navyPrimary
                          : AppColors.brownAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 24,
                      color: isSelected ? AppColors.white : AppColors.brownAccent,
                    ),
                  ),

                  // Animated Radio Checkmark
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.navyPrimary : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? AppColors.navyPrimary : AppColors.borderMuted,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 6),

              // Subtitle
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              // Divider
              Divider(
                color: isSelected
                    ? AppColors.brownAccent.withValues(alpha: 0.2)
                    : AppColors.borderMuted.withValues(alpha: 0.6),
                thickness: 1,
              ),

              const SizedBox(height: 12),

              // Perks List
              ...widget.perks.map(
                (perk) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 15,
                        color: isSelected ? AppColors.brownAccent : AppColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          perk,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? AppColors.navyPrimary : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
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
