import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_repository.dart';
import 'package:simple_gaming_flutter/feature/auth/login_notifier.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).observeAuthState(),
);

final loginNotifierProvider = AsyncNotifierProvider<LoginNotifier, void>(
  LoginNotifier.new,
);
