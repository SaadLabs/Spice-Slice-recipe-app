import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current logged-in user
  User? get currentUser => _auth.currentUser;

  // Listen to authentication changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Login
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          throw Exception('Invalid email or password.');

        case 'user-not-found':
          throw Exception('No account found with this email.');

        case 'wrong-password':
          throw Exception('Incorrect password.');

        case 'invalid-email':
          throw Exception('Invalid email address.');

        default:
          throw Exception(e.message ?? 'Login failed.');
      }
    }
  }

  // Register
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(name);

    return credential;
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
