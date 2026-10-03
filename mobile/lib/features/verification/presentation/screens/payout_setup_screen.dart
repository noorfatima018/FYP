import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/models/verification_data.dart';
import '../../presentation/providers/verification_provider.dart';
import '../../presentation/widgets/verification_step_progress.dart';
import '../../../../routes/app_routes.dart';

class PayoutSetupScreen extends ConsumerStatefulWidget {
  const PayoutSetupScreen({super.key});

  @override
  ConsumerState<PayoutSetupScreen> createState() => _PayoutSetupScreenState();
}

class _PayoutSetupScreenState extends ConsumerState<PayoutSetupScreen> {
  PayoutMethod _selectedMethod = PayoutMethod.bankTransfer;
  late final TextEditingController _titleController;
  late final TextEditingController _numberController;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Areeba Arif');
    _numberController = TextEditingController(text: 'PK36BAHL0000123456789012');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_titleController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Please enter the official account holder title.');
      return;
    }

    if (_numberController.text.trim().length < 8) {
      setState(() => _errorMessage = 'Please enter a valid IBAN or account number.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ref.read(verificationProvider.notifier).setPayoutDetails(
          method: _selectedMethod,
          title: _titleController.text.trim(),
          numberOrIban: _numberController.text.trim(),
        );

    await ref.read(verificationProvider.notifier).submitVerification();

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pushNamed(AppRoutes.verificationStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const VerificationStepProgress(
                currentStep: 4,
                totalSteps: 4,
                stepTitle: 'Payout Method',
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Setup Rental Earnings',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyPrimary,
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Connect your bank account or mobile wallet to automatically receive rental payouts from approved clients.',
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

              // Form Scrollable
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Method Selector Chips
                    const Text(
                      'SELECT PAYOUT CHANNEL',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.brownAccent,
                        letterSpacing: 0.6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ...PayoutMethod.values.map((method) {
                      final isSelected = _selectedMethod == method;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMethod = method),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.white : AppColors.sandContainer.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.navyPrimary : AppColors.borderMuted,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                method == PayoutMethod.bankTransfer
                                    ? Icons.account_balance_rounded
                                    : Icons.phone_iphone_rounded,
                                size: 20,
                                color: isSelected ? AppColors.navyPrimary : AppColors.brownAccent,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  method.displayName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                    color: isSelected ? AppColors.navyPrimary : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle_rounded, color: AppColors.navyPrimary, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 14),

                    // Account Title
                    AppTextField(
                      label: 'Account Holder Title / Name',
                      hintText: 'Must match your CNIC name exactly',
                      controller: _titleController,
                      prefixIcon: Icons.person_outline_rounded,
                      onChanged: (_) {
                        if (_errorMessage != null) setState(() => _errorMessage = null);
                      },
                    ),

                    const SizedBox(height: 14),

                    // IBAN or Mobile Number
                    AppTextField(
                      label: _selectedMethod == PayoutMethod.bankTransfer
                          ? 'Bank IBAN Number (24 Digits)'
                          : 'Wallet Account Mobile Number',
                      hintText: _selectedMethod == PayoutMethod.bankTransfer
                          ? 'PK36XXXX0000123456789012'
                          : '03XX XXXXXXX',
                      controller: _numberController,
                      prefixIcon: Icons.credit_card_rounded,
                      onChanged: (_) {
                        if (_errorMessage != null) setState(() => _errorMessage = null);
                      },
                    ),

                    const SizedBox(height: 16),

                    // Security Escrow Banner
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
                          Icon(Icons.shield_outlined, size: 18, color: AppColors.brownAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'RentWise automatically secures client security deposits in escrow and initiates direct payout transfer upon verified item handover.',
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

              // Bottom Submit Button
              AppButton(
                text: 'Complete Verification & Submit',
                isLoading: _isLoading,
                onPressed: _handleSubmit,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
