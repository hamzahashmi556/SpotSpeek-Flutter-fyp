import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spot_speek/domain/repositories.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    var isSuccess = false;
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.login(email, password);
      _errorMessage = '';
      _isLoading = false;
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Login failed';
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
    }
    notifyListeners();
    return isSuccess;
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.signup(email, password);
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
