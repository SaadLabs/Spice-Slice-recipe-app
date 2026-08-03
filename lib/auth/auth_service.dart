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
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already registered.');

        case 'weak-password':
          throw Exception('Password should be at least 6 characters.');

        case 'invalid-email':
          throw Exception('Please enter a valid email.');

        default:
          throw Exception(e.message ?? 'Registration failed.');
      }
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Update Name
Future<void> updateName(String name) async {
  await _auth.currentUser?.updateDisplayName(name);
  await _auth.currentUser?.reload();
}

// Change Password
Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
}) async {
  final user = _auth.currentUser;

  if (user == null || user.email == null) {
    throw Exception("User not found.");
  }

  final credential = EmailAuthProvider.credential(
    email: user.email!,
    password: currentPassword,
  );

  await user.reauthenticateWithCredential(credential);
  await user.updatePassword(newPassword);
}
}
