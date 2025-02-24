import 'dart:io';
import 'package:spot_speek/data/datasources/storage_data_source.dart';
import 'package:spot_speek/domain/repositories.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageDataSource _storageDateSource;

  StorageRepositoryImpl(this._storageDateSource);

  @override
  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    return await _storageDateSource.uploadProfileImage(imageFile, userId);
  }
}
