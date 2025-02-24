import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> createUser(String uid, String email, String name);
  Future<UserModel?> getUserData(String uid);
  Future<UserModel?> getUserFromCacheOrDatabase(String uid);
  Future<void> updateUserProfile(String userId, String name, String imageUrl);
  Stream<UserModel?> listenToMyUser();
}

abstract class StorageRepository {
  Future<String?> uploadProfileImage(File imageFile, String userId);
}

abstract class PostRepository {
  Stream<List<PostModel>> fetchNearbyPosts(Position position, double radius);
  Future<void> addPost(String content, Position position);
}

abstract class AuthRepository {
  Future<User?> signup(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> logout();
  Stream<User?> get authStateChanges;
}
