import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spot_speek/data/models/post_model.dart';

class PostDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final geo = GeoFlutterFire();

  Stream<List<PostModel>> fetchNearbyPosts(Position position, double radius) {
    final collection = _firestore.collection('posts');
    final geoRef = geo.collection(collectionRef: collection);

    return geoRef
        .within(
      center: GeoFirePoint(position.latitude, position.longitude),
      radius: radius, // Radius in KM
      field: 'location', // Firestore GeoPoint field
    )
        .map((querySnapshot) {
      return querySnapshot.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        return PostModel.fromJson(json);
      }).toList();
    });
  }

  Future<void> addPost(String content, Position position) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final PostModel post = PostModel(
          content: content,
          location: GeoFirePoint(position.latitude, position.longitude),
          userId: uid);
      final json = post.toJson();

      await _firestore.collection('posts').add(json);
    }
  }
}
