import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

/// A fake Firebase [User] that only exposes [uid].
/// All other members throw [UnimplementedError] via [Fake].
class FakeFirebaseUser extends Fake implements User {
  FakeFirebaseUser({String uid = 'test-uid'}) : _uid = uid;

  final String _uid;

  @override
  String get uid => _uid;
}
