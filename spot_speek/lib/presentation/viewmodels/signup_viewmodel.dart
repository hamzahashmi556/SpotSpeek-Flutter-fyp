import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spot_speek/data/repositories/auth_repository_impl.dart';
import 'package:spot_speek/data/repositories/user_repository_impl.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository;
  final UserRepositoryImpl _userRepository;

  SignUpViewModel(this._authRepository, this._userRepository);

  bool _isLoading = false;
  String? _errorMessage = null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    var isSuccess = false;
    try {
      final user = await _authRepository.signup(email, password);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.code}");
    } catch (e) {
      print("Error: $e");
      _errorMessage = e.toString();
    }
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _userRepository.createUser(user.uid, email, name);
        isSuccess = true;
      }
    } catch (e) {
      print("Error: $e");
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
