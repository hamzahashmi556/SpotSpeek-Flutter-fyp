import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spot_speek/data/models/user_model.dart';

class UserFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<UserModel> _cachedUsers = [];

  final StreamController<UserModel?> _userControllers = StreamController();

  // Create a new user document in Firestore
  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    final user =
        UserModel(uid: uid, name: name, email: email, profilePicture: '');
    final json = user.toJson();
    await _firestore.collection('users').doc(uid).set(json);
  }

  // Real-time Firestore Listener for User Data
  Stream<UserModel?> listenToUser() {
    var uid = _auth.currentUser?.uid ?? '';
    if (uid.isEmpty) return Stream.value(null);

    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    });
  }

  // Fetch user data from Firestore
  Future<UserModel?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null) {
      final user = UserModel.fromJson(data);
      return user;
    }
    return null;
  }

  Future<void> updateUserProfile(
      String userId, String name, String profilePicture) async {
    await _firestore.collection('users').doc(userId).set({
      'name': name,
      'profilePicture': profilePicture,
    }, SetOptions(merge: true));
  }

  Future<UserModel?> getUserFromCacheOrDatabase(String uid) async {
    final index = _cachedUsers.indexWhere((user) {
      return user.uid == uid;
    });
    if (index >= 0) {
      return _cachedUsers[index];
    }

    var fetchedUser = await getUserData(uid);
    if (fetchedUser != null) {
      _cachedUsers.add(fetchedUser);
      return fetchedUser;
    }
    return null;
  }
}
