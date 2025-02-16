import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spot_speek/data/repositories/post_repository.dart';
import 'package:spot_speek/data/models/post_model.dart';

class PostViewModel extends ChangeNotifier {
  final PostRepository _postRepository;
  Stream<List<PostModel>>? postsStream;

  PostViewModel(this._postRepository);

  void fetchNearbyPosts(Position position, double radius) {
    postsStream = _postRepository.getNearbyPosts(position, radius);
    notifyListeners();
  }
}
