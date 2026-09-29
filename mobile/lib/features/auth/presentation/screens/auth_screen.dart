import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/segmented_pill.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_hero_header.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_up_form.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isSignIn = authState.mode == AuthMode.signIn;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // Top Video/Logo Header Hero
              const AuthHeroHeader(),

              // Auth Content Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading
                      Text(
                        isSignIn ? AppStrings.welcomeBack : AppStrings.getStarted,
                        style: theme.textTheme.headlineLarge,
                      ),

                      const SizedBox(height: 20),

                      // Segmented Pill [ Sign In | Sign Up ]
                      SegmentedPill(
                        selectedIndex: isSignIn ? 0 : 1,
                        labels: const [AppStrings.signIn, AppStrings.signUp],
                        onSelected: (index) {
                          ref.read(authProvider.notifier).setMode(
                                index == 0 ? AuthMode.signIn : AuthMode.signUp,
                              );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Error Alert Banner
                      if (authState.errorMessage != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.errorRedBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.errorRedBorder),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                color: AppColors.errorRed,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  authState.errorMessage!,
                                  style: const TextStyle(
                                    color: AppColors.errorRed,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Success Alert Banner
                      if (authState.successMessage != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.successGreenBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.successGreenBorder),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                color: AppColors.successGreen,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  authState.successMessage!,
                                  style: const TextStyle(
                                    color: AppColors.successGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Animated Crossfade between Sign In and Sign Up Forms
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        firstChild: const SignInForm(),
                        secondChild: const SignUpForm(),
                        crossFadeState: isSignIn
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
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
