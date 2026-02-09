import 'package:firebase_core/firebase_core.dart';

class FirebaseInit {
  FirebaseInit._();

  static Future<void> init() async {
    await Firebase.initializeApp();
  }
}
