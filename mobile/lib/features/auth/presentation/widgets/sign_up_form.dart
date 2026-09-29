import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).signUp(
          _emailController.text.trim(),
          _passwordController.text,
          _confirmPasswordController.text,
        );
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
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.lock_outline_rounded,
          onChanged: (_) {
            if (authState.errorMessage != null) {
              ref.read(authProvider.notifier).clearMessages();
            }
          },
        ),

        const SizedBox(height: 16),

        // Confirm Password Field
        AppTextField(
          label: AppStrings.confirmPassword,
          hintText: AppStrings.confirmPasswordPlaceholder,
          controller: _confirmPasswordController,
          isPassword: true,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.lock_outline_rounded,
          onChanged: (_) {
            if (authState.errorMessage != null) {
              ref.read(authProvider.notifier).clearMessages();
            }
          },
        ),

        const SizedBox(height: 24),

        // Create Account Button
        AppButton(
          text: AppStrings.createAccountButton,
          isLoading: authState.isLoading,
          onPressed: _handleSignUp,
        ),
      ],
    );
  }
}
