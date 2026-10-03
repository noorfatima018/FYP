import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/verification_data.dart';

class VerificationNotifier extends StateNotifier<VerificationData> {
  VerificationNotifier() : super(const VerificationData());

  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  Future<bool> verifyOtp(String otp) async {
    // Simulate network OTP verification
    await Future.delayed(const Duration(milliseconds: 900));
    if (otp.length == 6) {
      state = state.copyWith(
        isPhoneVerified: true,
        trustScore: state.trustScore + 5,
      );
      return true;
    }
    return false;
  }

  void setCnicNumber(String cnic) {
    state = state.copyWith(cnicNumber: cnic);
  }

  void setCnicFront(String path) {
    state = state.copyWith(cnicFrontPath: path);
  }

  void setCnicBack(String path) {
    state = state.copyWith(cnicBackPath: path);
  }

  void setSelfie(String path) {
    state = state.copyWith(selfiePath: path);
  }

  void setPayoutDetails({
    required PayoutMethod method,
    required String title,
    required String numberOrIban,
  }) {
    state = state.copyWith(
      payoutMethod: method,
      accountTitle: title,
      accountNumberOrIban: numberOrIban,
    );
  }

  Future<void> submitVerification() async {
    // Simulate submission delay
    await Future.delayed(const Duration(milliseconds: 1200));
    state = state.copyWith(
      isSubmitted: true,
      trustScore: 75, // +25 points awarded on complete KYC submission
    );
  }

  void reset() {
    state = const VerificationData();
  }
}

final verificationProvider = StateNotifierProvider<VerificationNotifier, VerificationData>((ref) {
  return VerificationNotifier();
});
