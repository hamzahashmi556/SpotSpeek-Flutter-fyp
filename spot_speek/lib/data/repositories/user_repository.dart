import 'package:spot_speek/data/datasources/user_firestore_datasource.dart';

class UserRepository {
  final UserFirestoreDataSource _firestoreDataSource;

  UserRepository(this._firestoreDataSource);

  Future<void> createUser(
      {required String uid,
      required String email,
      required String name}) async {
    await _firestoreDataSource.createUser(uid: uid, email: email, name: name);
  }
}
