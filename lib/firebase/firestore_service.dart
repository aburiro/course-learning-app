import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');
  CollectionReference<Map<String, dynamic>> get _courses =>
      _db.collection('courses');

  Future<void> createOrUpdateUser(
    String uid, {
    String? name,
    String? email,
    String? photoUrl,
  }) async {
    await _users.doc(uid).set(
      {
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream(String uid) {
    return _users.doc(uid).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) {
    return _users.doc(uid).get();
  }

  Future<String> addCourse(Map<String, dynamic> data) async {
    final doc = await _courses.add(
      {
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
    return doc.id;
  }

  Future<void> updateCourse(String courseId, Map<String, dynamic> data) async {
    await _courses.doc(courseId).update(
      {
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> deleteCourse(String courseId) async {
    await _courses.doc(courseId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> coursesStream() {
    return _courses.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> enrollInCourse({
    required String uid,
    required String courseId,
    double progress = 0,
  }) async {
    await _users.doc(uid).collection('enrollments').doc(courseId).set(
      {
        'courseId': courseId,
        'progress': progress,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> updateProgress({
    required String uid,
    required String courseId,
    required double progress,
  }) async {
    await _users.doc(uid).collection('enrollments').doc(courseId).update(
      {
        'progress': progress,
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> enrollmentsStream(String uid) {
    return _users
        .doc(uid)
        .collection('enrollments')
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }
}
