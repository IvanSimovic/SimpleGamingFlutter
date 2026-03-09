import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> observeAuthState() => _auth.authStateChanges();

  String? getCurrentUserId() => _auth.currentUser?.uid;

  Future<void> signIn({required String email, required String password}) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();
}
