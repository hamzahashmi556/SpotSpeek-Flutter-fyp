import 'package:spot_speek/data/datasources/user_firestore_datasource.dart';
import 'package:spot_speek/data/models/user_model.dart';
import 'package:spot_speek/domain/repositories.dart';

class UserRepositoryImpl extends UserRepository {
  final UserFirestoreDataSource userDataSource;

  // Listen to Real-Time User Updates
  @override
  Stream<UserModel?> listenToMyUser() {
    return userDataSource.listenToUser();
  }

  UserRepositoryImpl({required this.userDataSource}) {}

  @override
  Future<void> createUser(String uid, String email, String name) async {
    return await userDataSource.createUser(uid: uid, email: email, name: name);
  }

  @override
  Future<UserModel?> getUserData(String uid) async {
    return await userDataSource.getUserData(uid);
  }

  @override
  Future<void> updateUserProfile(
      String userId, String name, String imageUrl) async {
    return userDataSource.updateUserProfile(userId, name, imageUrl);
  }

  @override
  Future<UserModel?> getUserFromCacheOrDatabase(String uid) async {
    return await userDataSource.getUserFromCacheOrDatabase(uid);
  }
}
