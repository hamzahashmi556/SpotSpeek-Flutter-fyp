import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_speek/data/models/post_model.dart';
import 'package:spot_speek/data/repositories/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository _postRepository;

  TextEditingController messageController = TextEditingController();

  Position? _selectedPosition;

  LatLng get currentCoordinates => LatLng(
      _selectedPosition?.latitude ?? 0, _selectedPosition?.longitude ?? 0);

  Stream<List<PostModel>>? _postsStream;

  HomeViewModel(this._postRepository) {
    _initialize();
  }

  Stream<List<PostModel>> get postsStream => _postsStream ?? Stream.value([]);

  void _initialize() async {
    try {
      _isLoading = true;
      notifyListeners();
      _selectedPosition = await Geolocator.getCurrentPosition();
      ;
      _updateStream();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updateStream() {
    if (_selectedPosition != null) {
      _postsStream =
          _postRepository.getNearbyPosts(_selectedPosition!, 5.0); // 5KM Radius

      _postsStream?.listen(
        (fetchedPosts) {
          _isLoading = false;
          _posts = fetchedPosts;
          notifyListeners();
        },
        onError: (_) {
          _isLoading = false;
          notifyListeners();
        },
        onDone: () {
          _isLoading = false;
          notifyListeners();
        },
      );
    }
  }

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  Position? _position;
  Position? get position => _position;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
/*
  Future<void> getLocationAndFetchPosts() async {
    try {
      _position = await Geolocator.getCurrentPosition();
      _postRepository.getNearbyPosts(_position!, 10).listen((fetchedPosts) {
        _posts = fetchedPosts;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
*/
  void updateLocation(LatLng newLocation) {
    _selectedPosition = Position(
      latitude: newLocation.latitude,
      longitude: newLocation.longitude,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 1,
      headingAccuracy: 1,
      timestamp: DateTime.now(),
    );
    _updateStream();
  }

  void sendMessage() async {
    if (messageController.text.isEmpty || _selectedPosition == null) return;

    await _postRepository.createPost(
      messageController.text,
      _selectedPosition!,
    );
    messageController.clear();
  }

  // Future<void> postMessage(String message) async {
  //   if (_position == null || message.isEmpty) return;
  //   await _postRepository.createPost(message, _position!);
  // }
}
