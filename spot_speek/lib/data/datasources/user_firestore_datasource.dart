import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spot_speek/data/models/user_model.dart';

class UserFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user document in Firestore
  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    final user = UserModel(uid: uid, name: name, email: email);
    final json = user.toJson();
    await _firestore.collection('users').doc(uid).set(json);
  }

  // Fetch user data from Firestore
  Future<UserModel?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null) {
      final user = UserModel.fromJson(data!);
      return user;
    }
    return null;
  }

  // Update user data in Firestore
  Future<void> updateUser({
    required String uid,
    String? name,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
