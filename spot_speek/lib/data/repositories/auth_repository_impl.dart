import 'package:firebase_auth/firebase_auth.dart';
import 'package:spot_speek/data/datasources/auth_data_source.dart';
import 'package:spot_speek/domain/repositories.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthDataSource _authSource;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthRepositoryImpl(this._authSource);

  @override
  Future<User?> login(String email, String password) async {
    return await _authSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    return await _authSource.logout();
  }

  @override
  Future<User?> signup(String email, String password) async {
    return await _authSource.signup(email, password);
  }
}
