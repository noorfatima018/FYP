import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Primary Brand Button with micro-press animation & loading state
class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.navyPrimary,
    this.textColor = AppColors.white,
    this.height = 54,
    this.icon,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          onFocusChange: (focused) {},
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.textColor,
            disabledBackgroundColor: widget.backgroundColor.withValues(alpha: 0.6),
            elevation: 3,
            shadowColor: widget.backgroundColor.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Listener(
            onPointerDown: (_) => setState(() => _isPressed = true),
            onPointerUp: (_) => setState(() => _isPressed = false),
            onPointerCancel: (_) => setState(() => _isPressed = false),
            child: Center(
              child: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: widget.textColor,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
