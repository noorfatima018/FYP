import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../presentation/providers/verification_provider.dart';
import '../../presentation/widgets/document_upload_box.dart';
import '../../presentation/widgets/verification_step_progress.dart';
import '../../../../routes/app_routes.dart';

class CnicCaptureScreen extends ConsumerStatefulWidget {
  const CnicCaptureScreen({super.key});

  @override
  ConsumerState<CnicCaptureScreen> createState() => _CnicCaptureScreenState();
}

class _CnicCaptureScreenState extends ConsumerState<CnicCaptureScreen> {
  late final TextEditingController _cnicController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _cnicController = TextEditingController(text: '35202-1234567-1');
  }

  @override
  void dispose() {
    _cnicController.dispose();
    super.dispose();
  }

  void _simulateCapture(bool isFront) {
    if (isFront) {
      ref.read(verificationProvider.notifier).setCnicFront('mock_front_path.jpg');
    } else {
      ref.read(verificationProvider.notifier).setCnicBack('mock_back_path.jpg');
    }
    if (_errorMessage != null) setState(() => _errorMessage = null);
  }

  void _handleContinue() {
    final data = ref.read(verificationProvider);

    if (_cnicController.text.trim().length < 13) {
      setState(() => _errorMessage = 'Please enter a valid 13-digit CNIC number.');
      return;
    }

    if (data.cnicFrontPath == null || data.cnicBackPath == null) {
      setState(() => _errorMessage = 'Please capture both Front and Back sides of your CNIC.');
      return;
    }

    ref.read(verificationProvider.notifier).setCnicNumber(_cnicController.text.trim());

    // Navigate to Step 3: Selfie Verification
    Navigator.of(context).pushNamed(AppRoutes.selfieVerification);
  }

  @override
  Widget build(BuildContext context) {
    final roleState = ref.watch(roleModeProvider);
    final verificationData = ref.watch(verificationProvider);
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
                currentStep: 2,
                totalSteps: totalSteps,
                stepTitle: 'National ID (CNIC)',
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Upload Government ID',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Please enter your CNIC number and upload clear, readable photos of the front and back sides.',
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

              // Scrollable Document Area
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // CNIC Number Input
                    AppTextField(
                      label: 'National Identity Number (CNIC)',
                      hintText: '35202-XXXXXXX-X',
                      controller: _cnicController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.badge_outlined,
                      onChanged: (_) {
                        if (_errorMessage != null) setState(() => _errorMessage = null);
                      },
                    ),

                    const SizedBox(height: 18),

                    // Front CNIC Upload Box
                    DocumentUploadBox(
                      title: 'CNIC Front Side',
                      subtitle: 'Photo showing full name, photo, and identity number',
                      imagePath: verificationData.cnicFrontPath,
                      onTap: () => _simulateCapture(true),
                      onClear: () {
                        ref.read(verificationProvider.notifier).setCnicFront('');
                      },
                    ),

                    const SizedBox(height: 14),

                    // Back CNIC Upload Box
                    DocumentUploadBox(
                      title: 'CNIC Back Side',
                      subtitle: 'Photo showing address and family registration code',
                      imagePath: verificationData.cnicBackPath,
                      onTap: () => _simulateCapture(false),
                      onClear: () {
                        ref.read(verificationProvider.notifier).setCnicBack('');
                      },
                    ),

                    const SizedBox(height: 16),

                    // Guidelines Tips Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.sandContainer.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderMuted.withValues(alpha: 0.6)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline_rounded, size: 18, color: AppColors.brownAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Ensure all 4 corners are visible, text is clearly legible, and there is no camera flash glare over your card.',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Bottom Action Button
              AppButton(
                text: 'Confirm & Continue to Selfie',
                onPressed: _handleContinue,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
