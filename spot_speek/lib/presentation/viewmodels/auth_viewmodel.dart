// presentation/viewmodels/auth_viewmodel.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spot_speek/data/repositories/auth_repository.dart';
// import 'package:spot_speek/domain/repositories/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.login(email, password);
      _errorMessage = '';
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Login failed';
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.signUp(email, password);
      _errorMessage = '';
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Signup failed';
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  void removeError() {
    _errorMessage = "";
    notifyListeners();
  }
}
