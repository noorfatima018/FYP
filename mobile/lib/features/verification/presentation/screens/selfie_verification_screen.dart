import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../presentation/providers/verification_provider.dart';
import '../../presentation/widgets/verification_step_progress.dart';
import '../../../../routes/app_routes.dart';

class SelfieVerificationScreen extends ConsumerStatefulWidget {
  const SelfieVerificationScreen({super.key});

  @override
  ConsumerState<SelfieVerificationScreen> createState() => _SelfieVerificationScreenState();
}

class _SelfieVerificationScreenState extends ConsumerState<SelfieVerificationScreen> {
  bool _isCaptured = false;
  bool _isLoading = false;
  String? _errorMessage;

  void _captureSelfie() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        ref.read(verificationProvider.notifier).setSelfie('mock_selfie_path.jpg');
        setState(() {
          _isLoading = false;
          _isCaptured = true;
        });
      }
    });
  }

  void _handleContinue() {
    if (!_isCaptured) {
      setState(() => _errorMessage = 'Please take a clear photo of your face before continuing.');
      return;
    }

    final roleState = ref.read(roleModeProvider);

    if (roleState.activeRole == UserRole.owner) {
      // Owner goes to Step 4: Payout setup
      Navigator.of(context).pushNamed(AppRoutes.payoutSetup);
    } else {
      // Renter submits KYC and goes to Status Screen
      ref.read(verificationProvider.notifier).submitVerification();
      Navigator.of(context).pushNamed(AppRoutes.verificationStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleState = ref.watch(roleModeProvider);
    final totalSteps = roleState.activeRole == UserRole.owner ? 4 : 3;

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navyPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Progress Bar
              VerificationStepProgress(
                currentStep: 3,
                totalSteps: totalSteps,
                stepTitle: 'Face Verification',
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Take a Quick Selfie',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Position your face inside the frame. Ensure good lighting and remove glasses or hats for automated facial matching.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              // Error Alert
              if (_errorMessage != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.errorRedBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.errorRedBorder),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: AppColors.errorRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Central Oval Face Frame
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 230,
                        height: 290,
                        decoration: BoxDecoration(
                          color: _isCaptured ? AppColors.white : AppColors.sandContainer,
                          borderRadius: BorderRadius.circular(120),
                          border: Border.all(
                            color: _isCaptured ? AppColors.successGreen : AppColors.brownAccent,
                            width: _isCaptured ? 3 : 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isCaptured
                                  ? AppColors.successGreen.withValues(alpha: 0.15)
                                  : AppColors.brownAccent.withValues(alpha: 0.12),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: _isCaptured
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 58,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: AppColors.successGreenBg,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.successGreenBorder),
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: AppColors.successGreen,
                                      size: 34,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  const Text(
                                    'Face Verified',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.navyPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Matches CNIC photo record',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.face_retouching_natural_rounded,
                                    size: 64,
                                    color: AppColors.brownAccent.withValues(alpha: 0.8),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Center Your Face',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.navyPrimary,
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(height: 16),

                      // Retake button if captured
                      if (_isCaptured)
                        TextButton.icon(
                          onPressed: () => setState(() => _isCaptured = false),
                          icon: const Icon(Icons.refresh_rounded, size: 16, color: AppColors.brownAccent),
                          label: const Text(
                            'Retake Photo',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brownAccent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button
              AppButton(
                text: _isCaptured
                    ? (roleState.activeRole == UserRole.owner
                        ? 'Next: Setup Payout Account'
                        : 'Submit Verification & View Profile')
                    : 'Capture Live Photo',
                isLoading: _isLoading,
                onPressed: _isCaptured ? _handleContinue : _captureSelfie,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
