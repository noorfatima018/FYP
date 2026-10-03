enum VerificationStep {
  phone,
  cnic,
  selfie,
  payout,
  completed,
}

enum PayoutMethod {
  bankTransfer,
  jazzCash,
  easyPaisa;

  String get displayName {
    switch (this) {
      case PayoutMethod.bankTransfer:
        return 'Bank Transfer (IBAN)';
      case PayoutMethod.jazzCash:
        return 'JazzCash Mobile Wallet';
      case PayoutMethod.easyPaisa:
        return 'Easypaisa Mobile Wallet';
    }
  }
}

class VerificationData {
  final String phoneNumber;
  final bool isPhoneVerified;
  final String cnicNumber;
  final String? cnicFrontPath;
  final String? cnicBackPath;
  final String? selfiePath;
  final PayoutMethod payoutMethod;
  final String accountTitle;
  final String accountNumberOrIban;
  final int trustScore;
  final bool isSubmitted;

  const VerificationData({
    this.phoneNumber = '',
    this.isPhoneVerified = false,
    this.cnicNumber = '',
    this.cnicFrontPath,
    this.cnicBackPath,
    this.selfiePath,
    this.payoutMethod = PayoutMethod.bankTransfer,
    this.accountTitle = '',
    this.accountNumberOrIban = '',
    this.trustScore = 50,
    this.isSubmitted = false,
  });

  VerificationData copyWith({
    String? phoneNumber,
    bool? isPhoneVerified,
    String? cnicNumber,
    String? cnicFrontPath,
    String? cnicBackPath,
    String? selfiePath,
    PayoutMethod? payoutMethod,
    String? accountTitle,
    String? accountNumberOrIban,
    int? trustScore,
    bool? isSubmitted,
  }) {
    return VerificationData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      cnicNumber: cnicNumber ?? this.cnicNumber,
      cnicFrontPath: cnicFrontPath ?? this.cnicFrontPath,
      cnicBackPath: cnicBackPath ?? this.cnicBackPath,
      selfiePath: selfiePath ?? this.selfiePath,
      payoutMethod: payoutMethod ?? this.payoutMethod,
      accountTitle: accountTitle ?? this.accountTitle,
      accountNumberOrIban: accountNumberOrIban ?? this.accountNumberOrIban,
      trustScore: trustScore ?? this.trustScore,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
