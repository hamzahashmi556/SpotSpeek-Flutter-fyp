// data/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? profilePicture;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.profilePicture});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
        uid: user.uid, name: '', email: user.email ?? '', profilePicture: '');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        profilePicture: json['profilePicture']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
