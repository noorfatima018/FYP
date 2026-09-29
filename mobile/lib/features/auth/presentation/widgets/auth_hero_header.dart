import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';

/// Top Logo Header for Auth Screen with transparent background and prominent height
class AuthHeroHeader extends StatelessWidget {
  const AuthHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 48, bottom: 20, left: 24, right: 24),
      child: Center(
        child: Image.asset(
          AppAssets.logoIcon,
          height: 115,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
