import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spot_speek/domain/repositories.dart';

class ProfileViewModel extends ChangeNotifier {
  final StorageRepository _storageRepository;
  final UserRepository _userRepository;
  final String _userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  ProfileViewModel(this._userRepository, this._storageRepository) {
    _fetchUserProfile();
  }

  TextEditingController nameController = TextEditingController();
  File? _selectedImage;
  String _profileImageUrl = "";

  File? get selectedImage => _selectedImage;
  String get profileImageUrl => _profileImageUrl;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();
    // final userData = await
    final userData = await _userRepository.getUserData(_userId);
    if (userData != null) {
      nameController.text = userData.name;
      _profileImageUrl = userData.profilePicture ?? '';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> pickProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<bool> saveProfile() async {
    var isSuccess = false;
    _isLoading = true;
    notifyListeners();

    String imageUrl = _profileImageUrl;
    if (_selectedImage != null) {
      imageUrl = await _storageRepository.uploadProfileImage(
              _selectedImage!, _userId) ??
          '';
    }

    await _userRepository.updateUserProfile(
        _userId, nameController.text, imageUrl);

    _profileImageUrl = imageUrl;
    _selectedImage = null;

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
