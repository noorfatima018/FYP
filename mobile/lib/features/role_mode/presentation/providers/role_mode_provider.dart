import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_role.dart';

class RoleModeState {
  final UserRole activeRole;
  final bool hasSelectedInitialRole;

  const RoleModeState({
    this.activeRole = UserRole.renter,
    this.hasSelectedInitialRole = false,
  });

  RoleModeState copyWith({
    UserRole? activeRole,
    bool? hasSelectedInitialRole,
  }) {
    return RoleModeState(
      activeRole: activeRole ?? this.activeRole,
      hasSelectedInitialRole: hasSelectedInitialRole ?? this.hasSelectedInitialRole,
    );
  }
}

class RoleModeNotifier extends StateNotifier<RoleModeState> {
  RoleModeNotifier() : super(const RoleModeState());

  void selectRole(UserRole role) {
    state = state.copyWith(
      activeRole: role,
      hasSelectedInitialRole: true,
    );
  }

  void switchMode() {
    final nextRole = state.activeRole == UserRole.renter ? UserRole.owner : UserRole.renter;
    state = state.copyWith(activeRole: nextRole);
  }
}

final roleModeProvider = StateNotifierProvider<RoleModeNotifier, RoleModeState>((ref) {
  return RoleModeNotifier();
});
