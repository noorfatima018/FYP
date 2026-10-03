import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../role_mode/domain/models/user_role.dart';
import '../../../role_mode/presentation/providers/role_mode_provider.dart';
import '../../presentation/providers/verification_provider.dart';
import '../../presentation/widgets/otp_pin_input.dart';
import '../../presentation/widgets/verification_step_progress.dart';
import '../../../../routes/app_routes.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  ConsumerState<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends ConsumerState<PhoneVerificationScreen> {
  late final TextEditingController _phoneController;
  bool _otpSent = false;
  String _otpCode = '';
  bool _isLoading = false;
  String? _errorMessage;

  Timer? _resendTimer;
  int _resendSeconds = 30;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: '03001234567');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _resendSeconds = 30;
    });
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _sendOtp() {
    if (_phoneController.text.trim().length < 10) {
      setState(() => _errorMessage = 'Please enter a valid 11-digit mobile number.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ref.read(verificationProvider.notifier).setPhoneNumber(_phoneController.text.trim());

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _otpSent = true;
        });
        _startResendCountdown();
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length < 6) {
      setState(() => _errorMessage = 'Please enter the 6-digit verification PIN.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await ref.read(verificationProvider.notifier).verifyOtp(_otpCode);

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        // Navigate to Step 2: CNIC Capture
        Navigator.of(context).pushNamed(AppRoutes.cnicCapture);
      } else {
        setState(() => _errorMessage = 'Invalid PIN code. Please check and try again.');
      }
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
                currentStep: 1,
                totalSteps: totalSteps,
                stepTitle: 'Phone Confirmation',
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                _otpSent ? 'Enter 6-Digit PIN' : 'Verify Mobile Number',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _otpSent
                    ? 'We have sent a 6-digit SMS code to ${_phoneController.text}. Enter it below to verify.'
                    : 'We will send a one-time secure PIN code via SMS to verify your identity and contact info.',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

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
                const SizedBox(height: 16),
              ],

              // Form Area
              if (!_otpSent) ...[
                AppTextField(
                  label: 'Mobile Phone Number',
                  hintText: '03XX XXXXXXX',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_android_rounded,
                  onChanged: (_) {
                    if (_errorMessage != null) setState(() => _errorMessage = null);
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  'Format: 03001234567 or +92 300 1234567',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ] else ...[
                // OTP Pin Input
                OtpPinInput(
                  length: 6,
                  onCompleted: (pin) {
                    _otpCode = pin;
                    _verifyOtp();
                  },
                  onChanged: (pin) {
                    _otpCode = pin;
                    if (_errorMessage != null) setState(() => _errorMessage = null);
                  },
                ),

                const SizedBox(height: 20),

                // Resend Timer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _resendSeconds > 0
                          ? 'Resend code in ${_resendSeconds}s'
                          : "Didn't receive code?",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: _resendSeconds == 0 ? _sendOtp : null,
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _resendSeconds == 0
                              ? AppColors.brownAccent
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const Spacer(),

              // Action Button
              AppButton(
                text: _otpSent ? 'Verify PIN & Continue' : 'Send Verification Code',
                isLoading: _isLoading,
                onPressed: _otpSent ? _verifyOtp : _sendOtp,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
