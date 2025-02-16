// data/datasources/remote_data_source.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> login(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
