import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';

enum LoginError { emailRequired, passwordRequired, signInFailed }

class LoginNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      state = AsyncError(LoginError.emailRequired, StackTrace.current);
      return;
    }
    if (password.isEmpty) {
      state = AsyncError(LoginError.passwordRequired, StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email.trim(), password: password);
      state = const AsyncData(null);
    } catch (_) {
      state = AsyncError(LoginError.signInFailed, StackTrace.current);
    }
  }
}
