import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';

enum AuthMode { signIn, signUp }

class AuthState {
  final AuthMode mode;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final bool rememberMe;

  const AuthState({
    this.mode = AuthMode.signIn,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.rememberMe = false,
  });

  AuthState copyWith({
    AuthMode? mode,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool? rememberMe,
  }) {
    return AuthState(
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void setMode(AuthMode mode) {
    state = state.copyWith(
      mode: mode,
      errorMessage: null,
      successMessage: null,
    );
  }

  void toggleRememberMe(bool? value) {
    state = state.copyWith(rememberMe: value ?? !state.rememberMe);
  }

  void clearMessages() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }

  Future<bool> signIn(String email, String password) async {
    final emailError = Validators.email(email);
    if (emailError != null) {
      state = state.copyWith(errorMessage: emailError);
      return false;
    }

    final passwordError = Validators.password(password);
    if (passwordError != null) {
      state = state.copyWith(errorMessage: passwordError);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    // Simulate network authentication
    await Future.delayed(const Duration(milliseconds: 1200));

    state = state.copyWith(
      isLoading: false,
      successMessage: AppStrings.signInSuccess,
    );
    return true;
  }

  Future<bool> signUp(String email, String password, String confirmPassword) async {
    final emailError = Validators.email(email);
    if (emailError != null) {
      state = state.copyWith(errorMessage: emailError);
      return false;
    }

    final passwordError = Validators.password(password);
    if (passwordError != null) {
      state = state.copyWith(errorMessage: passwordError);
      return false;
    }

    final confirmError = Validators.confirmPassword(confirmPassword, password);
    if (confirmError != null) {
      state = state.copyWith(errorMessage: confirmError);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    // Simulate network registration
    await Future.delayed(const Duration(milliseconds: 1200));

    state = state.copyWith(
      isLoading: false,
      successMessage: AppStrings.signUpSuccess,
    );
    return true;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
