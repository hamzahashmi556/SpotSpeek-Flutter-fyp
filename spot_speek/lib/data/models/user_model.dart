// data/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({required this.uid, required this.name, required this.email});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      name: '',
      email: user.email ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
