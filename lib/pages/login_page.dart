import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:longtut/components/my_button.dart';
import 'package:longtut/components/my_textfield.dart';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordNameController = TextEditingController();

  // New state to track if Google Sign-In is successful (for visual feedback)
  User? _firebaseUser;

  @override
  void initState() {
    super.initState();
    GoogleAuthHelper.instance.initialize();
  }

  void signUserIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userNameController.text,
          password: passwordNameController.text
      );
      print("Signed in with email: ${credential.user?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      // You would typically show a dialog or snackbar here.
    }
  }

  void onGooglePress() async {
    try {
      print("Try sign in");
      final gUser = await GoogleAuthHelper.instance.signInGoogleAccount();

      if (gUser != null) {
        final gAuth = await gUser.authentication;

        if (gAuth.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            idToken: gAuth.idToken,
          );

          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

          if (mounted) {
            print("Successfully signed in with Google and Firebase: ${userCredential.user?.email}");
          }
        } else {
          print("Google Sign-In failed: ID Token is missing (Authentication failed).");
        }
      } else {
        print("Google Sign-In cancelled or failed to get account.");
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Sign-In Error: ${e.message}');
    } catch (e) {
      print('General Google Sign-In Error: $e');
    }
  }

  void onApplePress() {}

  void onRegister() {}

  @override
  Widget build(BuildContext context) {
    // If the user is signed in, show a success message or navigate away
    if (_firebaseUser != null) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                'Welcome, ${_firebaseUser!.email ?? _firebaseUser!.uid}!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text('Sign Out'),
              )
            ],
          ),
        ),
      );
    }

    // Otherwise, show the login form
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 50),
                Text(
                  "Welcome back",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: userNameController,
                  hintText: 'User name',
                  isObscured: false,
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: passwordNameController,
                  hintText: 'password',
                  isObscured: true,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot password?")],
                ),
                const SizedBox(height: 25),
                MyButton(onTap: signUserIn),
                const SizedBox(height: 25),
                const Text("or continue with"),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onGooglePress,
                      icon: const Icon(Icons.g_mobiledata, size: 100),
                    ),
                    IconButton(
                      onPressed: onApplePress,
                      icon: const Icon(Icons.apple, size: 100),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                TextButton(onPressed: onRegister, child: const Text("Register now")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}