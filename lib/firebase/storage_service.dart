import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserProfileImage({
    required String uid,
    required File file,
  }) async {
    final ref = _storage.ref().child('users/$uid/profile.jpg');
    final uploadTask = await ref.putFile(file);
    return uploadTask.ref.getDownloadURL();
  }

  Future<String> uploadCourseImage({
    required String courseId,
    required File file,
  }) async {
    final ref = _storage.ref().child('courses/$courseId/thumbnail.jpg');
    final uploadTask = await ref.putFile(file);
    return uploadTask.ref.getDownloadURL();
  }

  Future<String> getUserProfileImageUrl(String uid) async {
    final ref = _storage.ref().child('users/$uid/profile.jpg');
    return ref.getDownloadURL();
  }
}
