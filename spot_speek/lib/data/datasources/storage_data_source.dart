import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
/*
import 'package:firebase_storage/firebase_storage.dart';

class StorageDataSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture(File imageFile, String userId) async {
    try {
      final ref = _storage.ref().child('profile_pictures/$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }
}
*/

class StorageDataSource {
  final String cloudName = "do1by8s5y";
  final String uploadPreset = "flutter_unsigned";

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      var uri =
          Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      var request = http.MultipartRequest("POST", uri)
        ..fields['upload_preset'] = uploadPreset
        // ..fields['']
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        String imageUrl = jsonResponse['secure_url'];
        return imageUrl;
      }
    } catch (e) {
      print("Image upload failed: $e");
    }
    return null;
  }
}
