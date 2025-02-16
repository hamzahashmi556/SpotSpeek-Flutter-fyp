import 'package:geolocator/geolocator.dart';
import 'package:spot_speek/data/datasources/post_data_source.dart';
import 'package:spot_speek/data/models/post_model.dart';

class PostRepository {
  final PostDataSource _postDataSource;

  PostRepository(this._postDataSource);

  Stream<List<PostModel>> getNearbyPosts(Position position, double radius) {
    return _postDataSource.fetchNearbyPosts(position, radius);
  }

  Future<void> createPost(String message, Position position) {
    return _postDataSource.addPost(message, position);
  }
}
