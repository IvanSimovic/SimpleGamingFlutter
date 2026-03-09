import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';

class LoginNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn({
    required String email,
    required String password,
    required String emailRequiredMessage,
    required String passwordRequiredMessage,
  }) async {
    if (email.trim().isEmpty) {
      state = AsyncError(emailRequiredMessage, StackTrace.current);
      return;
    }
    if (password.isEmpty) {
      state = AsyncError(passwordRequiredMessage, StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signIn(email: email.trim(), password: password),
    );
  }
}
