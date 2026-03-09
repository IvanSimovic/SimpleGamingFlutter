import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

const String _kServerClientId = '782408446064-mel55m9r3u6vc7qctk4d8or87ks1i4tm.apps.googleusercontent.com';
const List<String> _kScopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

/// A helper class to manage all Google Sign-In interactions.
class GoogleAuthHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GoogleAuthHelper._internal();

  static final GoogleAuthHelper instance = GoogleAuthHelper._internal();

  /// Initializes the Google Sign-In client.
  Future<void> initialize() async {
    await _googleSignIn.initialize(
      serverClientId: _kServerClientId,
    );
  }

  Stream<GoogleSignInAuthenticationEvent> get authenticationEvents =>
      _googleSignIn.authenticationEvents;

  /// Checks if the current user has the required scopes.
  Future<GoogleSignInClientAuthorization?> checkAuthorization(GoogleSignInAccount user) async {
    return user.authorizationClient.authorizationForScopes(_kScopes);
  }

  /// Triggers the explicit sign-in flow and returns the signed-in account.
  Future<GoogleSignInAccount?> signInGoogleAccount() async {
    try {
      // The authenticate() method returns the GoogleSignInAccount directly.
      final gUser = await _googleSignIn.authenticate();
      return gUser;
    } catch (e) {
      print('Google Sign In Error: $e');
      return null;
    }
  }

  /// Requests authorization for the required scopes.
  Future<void> authorizeScopes(GoogleSignInAccount user) async {
    await user.authorizationClient.authorizeScopes(_kScopes);
  }

  /// Signs out the user by calling disconnect.
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
  }
}