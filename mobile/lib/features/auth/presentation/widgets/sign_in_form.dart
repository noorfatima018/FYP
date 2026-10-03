import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    FocusScope.of(context).unfocus();
    final success = await ref.read(authProvider.notifier).signIn(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (success && mounted) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.roleSelection);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email Field
        AppTextField(
          label: AppStrings.email,
          hintText: AppStrings.emailPlaceholder,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.email_outlined,
          onChanged: (_) {
            if (authState.errorMessage != null) {
              ref.read(authProvider.notifier).clearMessages();
            }
          },
        ),

        const SizedBox(height: 16),

        // Password Field
        AppTextField(
          label: AppStrings.password,
          hintText: AppStrings.passwordPlaceholder,
          controller: _passwordController,
          isPassword: true,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.lock_outline_rounded,
          onChanged: (_) {
            if (authState.errorMessage != null) {
              ref.read(authProvider.notifier).clearMessages();
            }
          },
        ),

        const SizedBox(height: 14),

        // Remember Me & Forgot Password Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: authState.rememberMe,
                    onChanged: (val) {
                      ref.read(authProvider.notifier).toggleRememberMe(val);
                    },
                    activeColor: AppColors.brownAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: AppColors.borderMuted,
                      width: 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    ref.read(authProvider.notifier).toggleRememberMe(!authState.rememberMe);
                  },
                  child: const Text(
                    AppStrings.rememberMe,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyPrimary,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // Future: navigate to forgot password flow
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                AppStrings.forgotPassword,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brownAccent,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Sign In Button
        AppButton(
          text: AppStrings.signInButton,
          isLoading: authState.isLoading,
          onPressed: _handleSignIn,
        ),
      ],
    );
  }
}
