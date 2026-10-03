import 'package:flutter/material.dart';

/// User Role / Active Mode in RentWise
enum UserRole {
  renter,
  owner;

  String get displayName {
    switch (this) {
      case UserRole.renter:
        return 'Client / Renter';
      case UserRole.owner:
        return 'Asset Owner / Host';
    }
  }

  String get shortName {
    switch (this) {
      case UserRole.renter:
        return 'Renter';
      case UserRole.owner:
        return 'Owner';
    }
  }

  String get tagLine {
    switch (this) {
      case UserRole.renter:
        return 'Access premium assets safely without purchasing';
      case UserRole.owner:
        return 'Turn your idle high-value assets into passive income';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.renter:
        return Icons.shopping_bag_outlined;
      case UserRole.owner:
        return Icons.storefront_outlined;
    }
  }
}
