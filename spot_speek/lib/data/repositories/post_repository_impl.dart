import 'package:geolocator/geolocator.dart';
import 'package:spot_speek/data/datasources/post_data_source.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/domain/repositories.dart';

class PostRepositoryImpl extends PostRepository {
  final PostDataSource _postDataSource;

  PostRepositoryImpl(this._postDataSource);

  @override
  Stream<List<PostModel>> fetchNearbyPosts(Position position, double radius) {
    return _postDataSource.fetchNearbyPosts(position, radius);
  }

  @override
  Future<void> addPost(String message, Position position) async {
    return _postDataSource.addPost(message, position);
  }
}
