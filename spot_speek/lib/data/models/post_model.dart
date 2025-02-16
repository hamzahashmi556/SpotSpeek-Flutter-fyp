import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  final String id = Uuid().v4();
  final String content;
  final GeoFirePoint location;
  final String userId;
  final DateTime createdAt = DateTime.now();

  PostModel({
    String? id,
    required this.content,
    required this.location,
    required this.userId,
    DateTime? createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      location: GeoFirePoint(
        (json['location']['geopoint'] as GeoPoint).latitude,
        (json['location']['geopoint'] as GeoPoint).longitude,
      ),
      userId: json['userId'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'location': location.data,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
