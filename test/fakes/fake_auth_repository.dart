import 'package:mocktail/mocktail.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_repository.dart';

class FakeAuthRepository extends Fake implements AuthRepository {
  Exception? signInException;

  @override
  Future<void> signIn({required String email, required String password}) async {
    if (signInException != null) throw signInException!;
  }

  @override
  Future<void> signOut() async {}
}
