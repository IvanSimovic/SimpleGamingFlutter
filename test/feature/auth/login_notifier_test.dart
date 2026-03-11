import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/auth/login_notifier.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository fakeRepo;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = FakeAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(fakeRepo)],
    );
    addTearDown(container.dispose);
  });

  Future<void> signIn({
    String email = 'user@example.com',
    String password = 'password',
  }) async {
    // Wait for build() to complete so it doesn't overwrite state set by signIn.
    await container.read(loginNotifierProvider.future);
    await container
        .read(loginNotifierProvider.notifier)
        .signIn(email: email, password: password);
  }

  test('empty email sets error state with email required error', () async {
    await signIn(email: '');
    expect(container.read(loginNotifierProvider), isA<AsyncError>());
    expect(
      container.read(loginNotifierProvider).error,
      LoginError.emailRequired,
    );
  });

  test('whitespace-only email sets error state', () async {
    await signIn(email: '   ');
    expect(container.read(loginNotifierProvider), isA<AsyncError>());
    expect(
      container.read(loginNotifierProvider).error,
      LoginError.emailRequired,
    );
  });

  test(
    'empty password sets error state with password required error',
    () async {
      await signIn(password: '');
      expect(container.read(loginNotifierProvider), isA<AsyncError>());
      expect(
        container.read(loginNotifierProvider).error,
        LoginError.passwordRequired,
      );
    },
  );

  test('valid credentials transition to data state', () async {
    await signIn();
    expect(container.read(loginNotifierProvider), isA<AsyncData<void>>());
  });

  test('repository failure sets signInFailed error', () async {
    fakeRepo.signInException = Exception('auth failed');
    await signIn();
    expect(container.read(loginNotifierProvider), isA<AsyncError>());
    expect(
      container.read(loginNotifierProvider).error,
      LoginError.signInFailed,
    );
  });

  test('trim is applied to email before calling repository', () async {
    // Padded email should still succeed — trim is applied before validation
    await signIn(email: '  user@example.com  ');
    expect(container.read(loginNotifierProvider), isA<AsyncData<void>>());
  });
}
