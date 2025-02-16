import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:spot_speek/data/repositories/auth_repository.dart';
import 'package:spot_speek/data/repositories/user_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

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
      final user = await _authRepository.signUp(email, password);
      if (user != null) {
        await _userRepository.createUser(
            uid: user.uid, email: email, name: name);
      }
      isSuccess = true;
    } catch (e) {
      print("Error: $e");
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
