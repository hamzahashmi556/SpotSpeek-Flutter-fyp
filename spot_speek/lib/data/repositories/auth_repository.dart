import 'package:firebase_auth/firebase_auth.dart';
import 'package:spot_speek/data/datasources/auth_data_source.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthDataSource _authSource;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthRepository(this._authSource);

  Future<User?> signUp(String email, String password) async {
    return await _authSource.signup(email, password);
  }

  //@override
  Future<void> login(String email, String password) async {
    try {
      await _authSource.login(email, password);
    } catch (e) {
      throw e;
    }
  }

  //@override
  Future<void> logout() async {
    await _authSource.logout();
  }
}
