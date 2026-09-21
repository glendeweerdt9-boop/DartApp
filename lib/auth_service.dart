import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> registerWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    if (displayName.trim().isNotEmpty) {
      await credential.user?.updateDisplayName(displayName.trim());
    }
    return credential;
  }

  Future<void> sendPasswordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      return _auth.signInWithPopup(provider);
    }

    final google = GoogleSignIn.instance;
    await google.initialize();
    final account = await google.authenticate();
    final authentication = account.authentication;
    final idToken = authentication.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'google-id-token-missing',
        message: 'Google gaf geen ID-token terug.',
      );
    }
    final credential = GoogleAuthProvider.credential(idToken: idToken);
    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    if (!kIsWeb) {
      await GoogleSignIn.instance.signOut();
    }
    await _auth.signOut();
  }
}
