import 'package:flutter/material.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/role_mode/presentation/screens/role_selection_screen.dart';
import '../features/verification/presentation/screens/verification_intro_screen.dart';
import '../features/verification/presentation/screens/phone_verification_screen.dart';
import '../features/verification/presentation/screens/cnic_capture_screen.dart';
import '../features/verification/presentation/screens/selfie_verification_screen.dart';
import '../features/verification/presentation/screens/payout_setup_screen.dart';
import '../features/verification/presentation/screens/verification_status_screen.dart';
import '../features/renter/presentation/screens/renter_home_screen.dart';
import '../features/owner/presentation/screens/owner_dashboard_screen.dart';
import '../features/trust_profile/presentation/screens/trust_profile_screen.dart';

/// Centralized application routes with smooth transitions
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String auth = '/auth';
  static const String roleSelection = '/role-selection';
  static const String verificationIntro = '/verification-intro';
  static const String phoneVerification = '/phone-verification';
  static const String cnicCapture = '/cnic-capture';
  static const String selfieVerification = '/selfie-verification';
  static const String payoutSetup = '/payout-setup';
  static const String verificationStatus = '/verification-status';
  static const String renterHome = '/renter-home';
  static const String ownerDashboard = '/owner-dashboard';
  static const String trustProfile = '/trust-profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case auth:
        return _buildFadeSlideRoute(const AuthScreen(), settings);

      case roleSelection:
        return _buildFadeSlideRoute(const RoleSelectionScreen(), settings);

      case verificationIntro:
        return _buildFadeSlideRoute(const VerificationIntroScreen(), settings);

      case phoneVerification:
        return _buildFadeSlideRoute(const PhoneVerificationScreen(), settings);

      case cnicCapture:
        return _buildFadeSlideRoute(const CnicCaptureScreen(), settings);

      case selfieVerification:
        return _buildFadeSlideRoute(const SelfieVerificationScreen(), settings);

      case payoutSetup:
        return _buildFadeSlideRoute(const PayoutSetupScreen(), settings);

      case verificationStatus:
        return _buildFadeSlideRoute(const VerificationStatusScreen(), settings);

      case renterHome:
        return _buildFadeSlideRoute(const RenterHomeScreen(), settings);

      case ownerDashboard:
        return _buildFadeSlideRoute(const OwnerDashboardScreen(), settings);

      case trustProfile:
        return _buildFadeSlideRoute(const TrustProfileScreen(), settings);

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  static PageRouteBuilder _buildFadeSlideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
      settings: settings,
    );
  }
}
